package calibrate

// Native function calibration benchmarks (pure-CPU side, end-to-end via dispatcher).
//
// Each bench drives the GnoVM dispatcher's native-call path:
//   stdlibs.NativeResolver(pkg, name)(m)
//
// This invokes the same closure stored in *FuncValue.nativeBody — the
// generated wrapper from gnovm/stdlibs/generated.go — which performs
// Gno→Go reflective parameter conversion, calls the X_ function, and
// converts return values back. Measurement therefore captures the FULL
// dispatch cost (reflect overhead + X_ work + Go2GnoValue return push).
//
// chargeNativeGas runs in the actual production path before this wrapper.
// We do NOT call it here — the per-function gas formula (Base + Slope*N)
// derived from these benches IS the total dispatcher charge in the new
// runtime model. There's no separate OpCPUNativeDispatch floor.
//
// Run:
//   cd gnovm/cmd/calibrate
//   go test -bench=BenchmarkNative -benchtime=200ms -count=3 -timeout=15m . \
//       > native_bench_output.txt
//   python3 gen_native_table.py native_bench_output.txt

import (
	"crypto/ed25519"
	"crypto/rand"
	"encoding/hex"
	"math"
	"reflect"
	"strings"
	"testing"

	gno "github.com/gnolang/gno/gnovm/pkg/gnolang"
	"github.com/gnolang/gno/gnovm/stdlibs"
	"github.com/gnolang/gno/gnovm/stdlibs/crypto/cometbls"
	tmcrypto "github.com/gnolang/gno/tm2/pkg/crypto"
	tmmerkle "github.com/gnolang/gno/tm2/pkg/crypto/merkle"
	"github.com/gnolang/gno/tm2/pkg/crypto/secp256k1"
)

// dispatchHarness drives the native dispatcher wrapper and resets the
// value stack between iterations.
type dispatchHarness struct {
	m        *gno.Machine
	wrapper  func(*gno.Machine)
	nReturns int
}

func (h *dispatchHarness) call() {
	h.wrapper(h.m)
	if h.nReturns > 0 {
		_ = h.m.PopValues(h.nReturns)
	}
}

// newDispatchMachine builds a Machine with Alloc + Store + a single Block
// of `nParams` slots. The caller populates Block.Values[i] with TVs built
// via gno.Go2GnoValue. Frames are set up by the caller for natives that
// need them (Context-readers, frame-walkers).
func newDispatchMachine(nParams int) *gno.Machine {
	m := &gno.Machine{
		Alloc: gno.NewAllocator(math.MaxInt64),
		Stage: gno.StageRun,
	}
	m.Blocks = []*gno.Block{{Values: make([]gno.TypedValue, nParams)}}
	return m
}

// setBlockValueFromGo populates Block.Values[idx] with a TV built from a
// reflect.Value of the desired Go type. The wrapper's reflect-based
// Gno2GnoValue conversion will read the result.
func setBlockValueFromGo(m *gno.Machine, idx int, v interface{}) {
	m.Blocks[0].Values[idx] = gno.Go2GnoValue(m.Alloc, m.Store, reflect.ValueOf(v))
}

// resolveWrapper panics if the (pkg, name) isn't registered. Use to fail
// fast in bench setup rather than nil-deref in the hot loop.
func resolveWrapper(b *testing.B, pkg string, name gno.Name) func(*gno.Machine) {
	b.Helper()
	w := stdlibs.NativeResolver(pkg, name)
	if w == nil {
		b.Fatalf("native %s.%s not found", pkg, name)
	}
	return w
}

// ----- crypto/sha256.sum256(data []byte) [32]byte -----

func benchSHA256(b *testing.B, n int) {
	b.Helper()
	data := make([]byte, n)
	rand.Read(data)
	m := newDispatchMachine(1)
	setBlockValueFromGo(m, 0, data)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "crypto/sha256", "sum256"), nReturns: 1}
	b.ResetTimer()
	b.SetBytes(int64(n))
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

func BenchmarkNative_SHA256_Sum256_0(b *testing.B)     { benchSHA256(b, 0) }
func BenchmarkNative_SHA256_Sum256_64(b *testing.B)    { benchSHA256(b, 64) }
func BenchmarkNative_SHA256_Sum256_256(b *testing.B)   { benchSHA256(b, 256) }
func BenchmarkNative_SHA256_Sum256_1024(b *testing.B)  { benchSHA256(b, 1024) }
func BenchmarkNative_SHA256_Sum256_4096(b *testing.B)  { benchSHA256(b, 4096) }
func BenchmarkNative_SHA256_Sum256_16384(b *testing.B) { benchSHA256(b, 16384) }
func BenchmarkNative_SHA256_Sum256_65536(b *testing.B) { benchSHA256(b, 65536) }

// ----- crypto/ed25519.verify(pub, msg, sig []byte) bool -----

func benchEd25519Verify(b *testing.B, msgLen int) {
	b.Helper()
	pub, priv, err := ed25519.GenerateKey(rand.Reader)
	if err != nil {
		b.Fatal(err)
	}
	msg := make([]byte, msgLen)
	rand.Read(msg)
	sig := ed25519.Sign(priv, msg)
	m := newDispatchMachine(3)
	setBlockValueFromGo(m, 0, []byte(pub))
	setBlockValueFromGo(m, 1, msg)
	setBlockValueFromGo(m, 2, sig)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "crypto/ed25519", "verify"), nReturns: 1}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

func BenchmarkNative_Ed25519_Verify_64(b *testing.B)    { benchEd25519Verify(b, 64) }
func BenchmarkNative_Ed25519_Verify_256(b *testing.B)   { benchEd25519Verify(b, 256) }
func BenchmarkNative_Ed25519_Verify_1024(b *testing.B)  { benchEd25519Verify(b, 1024) }
func BenchmarkNative_Ed25519_Verify_4096(b *testing.B)  { benchEd25519Verify(b, 4096) }
func BenchmarkNative_Ed25519_Verify_16384(b *testing.B) { benchEd25519Verify(b, 16384) }

// ----- math.Float{32,64}{bits,frombits} -----

func benchMathFlat(b *testing.B, fn gno.Name, paramVal interface{}) {
	b.Helper()
	m := newDispatchMachine(1)
	setBlockValueFromGo(m, 0, paramVal)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "math", fn), nReturns: 1}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

func BenchmarkNative_Math_Float32bits(b *testing.B) { benchMathFlat(b, "Float32bits", float32(1.5)) }
func BenchmarkNative_Math_Float32frombits(b *testing.B) {
	benchMathFlat(b, "Float32frombits", uint32(0x3FC00000))
}
func BenchmarkNative_Math_Float64bits(b *testing.B) { benchMathFlat(b, "Float64bits", float64(1.5)) }
func BenchmarkNative_Math_Float64frombits(b *testing.B) {
	benchMathFlat(b, "Float64frombits", uint64(0x3FF8000000000000))
}

// ----- chain.packageAddress(pkgPath string) string -----

func benchChainPackageAddress(b *testing.B, n int) {
	b.Helper()
	pkgPath := strings.Repeat("x", n)
	m := newDispatchMachine(1)
	setBlockValueFromGo(m, 0, pkgPath)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "chain", "packageAddress"), nReturns: 1}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

func BenchmarkNative_Chain_PackageAddress_1(b *testing.B)    { benchChainPackageAddress(b, 1) }
func BenchmarkNative_Chain_PackageAddress_10(b *testing.B)   { benchChainPackageAddress(b, 10) }
func BenchmarkNative_Chain_PackageAddress_100(b *testing.B)  { benchChainPackageAddress(b, 100) }
func BenchmarkNative_Chain_PackageAddress_1000(b *testing.B) { benchChainPackageAddress(b, 1000) }

// ----- chain.deriveStorageDepositAddr(pkgPath string) string -----

func benchChainDeriveStorageDepositAddr(b *testing.B, n int) {
	b.Helper()
	pkgPath := strings.Repeat("x", n)
	m := newDispatchMachine(1)
	setBlockValueFromGo(m, 0, pkgPath)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "chain", "deriveStorageDepositAddr"), nReturns: 1}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

func BenchmarkNative_Chain_DeriveStorageDepositAddr_1(b *testing.B) {
	benchChainDeriveStorageDepositAddr(b, 1)
}

func BenchmarkNative_Chain_DeriveStorageDepositAddr_10(b *testing.B) {
	benchChainDeriveStorageDepositAddr(b, 10)
}

func BenchmarkNative_Chain_DeriveStorageDepositAddr_100(b *testing.B) {
	benchChainDeriveStorageDepositAddr(b, 100)
}

func BenchmarkNative_Chain_DeriveStorageDepositAddr_1000(b *testing.B) {
	benchChainDeriveStorageDepositAddr(b, 1000)
}

// ----- chain.pubKeyAddress(bech32PubKey string) (addr, errStr string) -----

func BenchmarkNative_Chain_PubKeyAddress(b *testing.B) {
	priv := secp256k1.GenPrivKey()
	pubBech32 := tmcrypto.PubKeyToBech32(priv.PubKey())
	m := newDispatchMachine(1)
	setBlockValueFromGo(m, 0, pubBech32)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "chain", "pubKeyAddress"), nReturns: 2}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

// ----- time.loadFromEmbeddedTZData(name string) (data []byte, found bool) -----

func BenchmarkNative_Time_LoadTZData(b *testing.B) {
	m := newDispatchMachine(1)
	setBlockValueFromGo(m, 0, "America/New_York")
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "time", "loadFromEmbeddedTZData"), nReturns: 2}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

// hexBytes is a panic-on-error helper for benches that embed canonical test
// vectors (EIP-196/197, CometBLS happy-path proof).
func hexBytes(s string) []byte {
	out, err := hex.DecodeString(s)
	if err != nil {
		panic(err)
	}
	return out
}

// ----- crypto/keccak256.sum256(data []byte) [32]byte -----

func benchKeccak256(b *testing.B, n int) {
	b.Helper()
	data := make([]byte, n)
	rand.Read(data)
	m := newDispatchMachine(1)
	setBlockValueFromGo(m, 0, data)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "crypto/keccak256", "sum256"), nReturns: 1}
	b.ResetTimer()
	b.SetBytes(int64(n))
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

func BenchmarkNative_Keccak256_Sum256_0(b *testing.B)     { benchKeccak256(b, 0) }
func BenchmarkNative_Keccak256_Sum256_64(b *testing.B)    { benchKeccak256(b, 64) }
func BenchmarkNative_Keccak256_Sum256_256(b *testing.B)   { benchKeccak256(b, 256) }
func BenchmarkNative_Keccak256_Sum256_1024(b *testing.B)  { benchKeccak256(b, 1024) }
func BenchmarkNative_Keccak256_Sum256_4096(b *testing.B)  { benchKeccak256(b, 4096) }
func BenchmarkNative_Keccak256_Sum256_16384(b *testing.B) { benchKeccak256(b, 16384) }
func BenchmarkNative_Keccak256_Sum256_65536(b *testing.B) { benchKeccak256(b, 65536) }

// ----- crypto/bn254.g1Add (flat — input padded/truncated to 128 bytes) -----
//
// EIP-196 "chfast1" vector: two non-trivial G1 points being added. Total cost
// is independent of input length, so this is a flat fit; we use 128 bytes so
// both parseG1 paths and the gnark-crypto Add() are exercised.
var bn254G1AddInput = hexBytes(
	"18b18acfb4c2c30276db5411368e7185b311dd124691610c5d3b74034e093dc9" +
		"063c909c4720840cb5134cb9f59fa749755796819658d32efc0d288198f37266" +
		"07c2b7f58a84bd6145f00c9c2bc0bb1a187f20ff2c92963a88019e7c6a014eed" +
		"06614e20c147e940f2d70da3f74c9a17df361706a4485c742bd6788478fa17d7")

func BenchmarkNative_BN254_G1Add(b *testing.B) {
	m := newDispatchMachine(1)
	setBlockValueFromGo(m, 0, bn254G1AddInput)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "crypto/bn254", "g1Add"), nReturns: 1}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

// ----- crypto/bn254.g1Mul (flat — fixed-shape 96-byte input: G1 || scalar) -----
//
// G1 generator (x=1, y=2) times a non-trivial 256-bit scalar. The scalar's
// high bit is set so gnark-crypto exercises the full scalar-mul ladder.
var bn254G1MulInput = func() []byte {
	out := make([]byte, 96)
	out[31] = 1
	out[63] = 2
	copy(out[64:96], hexBytes("ffffffffffffffffffffffffffffffff0123456789abcdef0123456789abcdef"))
	return out
}()

func BenchmarkNative_BN254_G1Mul(b *testing.B) {
	m := newDispatchMachine(1)
	setBlockValueFromGo(m, 0, bn254G1MulInput)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "crypto/bn254", "g1Mul"), nReturns: 1}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

// ----- crypto/bn254.pairingCheck (linear on number of pairings) -----
//
// One canonical e(G, G2) pair (192 bytes); concatenated nPairs times. Slope
// fits on len(input) since the runtime SizeLenBytes axis reads bytes, not
// pair count.
var bn254OnePairInput = hexBytes(
	"0000000000000000000000000000000000000000000000000000000000000001" +
		"0000000000000000000000000000000000000000000000000000000000000002" +
		"198e9393920d483a7260bfb731fb5d25f1aa493335a9e71297e485b7aef312c2" +
		"1800deef121f1e76426a00665e5c4479674322d4f75edadd46debd5cd992f6ed" +
		"090689d0585ff075ec9e99ad690c3395bc4b313370b38ef355acdadcd122975b" +
		"12c85ea5db8c6deb4aab71808dcb408fe3d1e7690c43d37b4ce6cc0166fa7daa")

func benchBN254PairingCheck(b *testing.B, nPairs int) {
	b.Helper()
	input := make([]byte, 0, len(bn254OnePairInput)*nPairs)
	for i := 0; i < nPairs; i++ {
		input = append(input, bn254OnePairInput...)
	}
	m := newDispatchMachine(1)
	setBlockValueFromGo(m, 0, input)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "crypto/bn254", "pairingCheck"), nReturns: 1}
	b.ResetTimer()
	b.SetBytes(int64(len(input)))
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

func BenchmarkNative_BN254_PairingCheck_0(b *testing.B)    { benchBN254PairingCheck(b, 0) }
func BenchmarkNative_BN254_PairingCheck_192(b *testing.B)  { benchBN254PairingCheck(b, 1) }
func BenchmarkNative_BN254_PairingCheck_384(b *testing.B)  { benchBN254PairingCheck(b, 2) }
func BenchmarkNative_BN254_PairingCheck_768(b *testing.B)  { benchBN254PairingCheck(b, 4) }
func BenchmarkNative_BN254_PairingCheck_1536(b *testing.B) { benchBN254PairingCheck(b, 8) }

// ----- crypto/cometbls.verifyZKP (flat — Groth16 verification dominates) -----
//
// Test vector verbatim from crypto/cometbls/cometbls_test.go::TestXVerifyZKPHappyPath.
const (
	benchCometBLSChainID  = "union-devnet-1337"
	benchCometBLSProofHex = "03CF56142A1E03D2445A82100FEAF70C1CD95A731ED85792AFFF5792EC0BDD2108991BB56F9043A269F88903DE616A9AB99A3C5AB778E566744B060456C5616C" +
		"06BCE7F1930421768C2CBD79F88D08EC3A52D7C9A867064E973064385E9C945E02951190DD7CE1662546733DD540188C96E608CA750FEF36B39E2577833634C7" +
		"0AE6F1A6D00DC6C21446AAF285EF35D944E8782B131300574F9A889C7E708A2325E9A78013BBE869D38B19C602DAF69644C77D177E99ED76398BCEE13C61FDBF" +
		"2E178A5BA028A36033E54D1D9A0071E82E04079A5305347EBAC6D66F6EBFA48B1DA1BF9DC5A51EFA292E1DC7B85D26F18422EB386C48CA75434039764448BB96" +
		"268DDC2CF683DDCA4BD83DF21C5631CF784375EEBE77EABC2DE77886BF1D48392C9C52E063B4A7131EAB9ABBA12A9F26888BC37366D41AC7D4BAC0BF6755ACB0" +
		"09BF9F36F380B6D0EEAABF066503A1B6E01DCC965D968D7694E01B1755E6BDD21C7A80B41682748F9B7151714BE34AA79AAD48BBB2A84525F6CDF812658C6E4F"
)

var (
	benchCometBLSTVH = hexBytes("20DDFE7A0F75C65D876316091ECCD494A54A2BB324C872015F73E528D53CB9C4")
	benchCometBLSZKP = hexBytes(benchCometBLSProofHex)

	benchCometBLSEncodedHeader = cometbls.EncodeLightHeader(cometbls.LightHeader{
		Height:             3405691582,
		TimeSeconds:        1732205251,
		TimeNanos:          998131342,
		ValidatorsHash:     toArray32(benchCometBLSTVH),
		NextValidatorsHash: toArray32(benchCometBLSTVH),
		AppHash:            toArray32(hexBytes("EE7E3E58F98AC95D63CE93B270981DF3EE54CA367F8D521ED1F444717595CD36")),
	})
)

func toArray32(b []byte) [32]byte {
	var out [32]byte
	copy(out[:], b)
	return out
}

func BenchmarkNative_CometBLS_VerifyZKP(b *testing.B) {
	m := newDispatchMachine(4)
	setBlockValueFromGo(m, 0, benchCometBLSChainID)
	setBlockValueFromGo(m, 1, benchCometBLSTVH)
	setBlockValueFromGo(m, 2, benchCometBLSEncodedHeader)
	setBlockValueFromGo(m, 3, benchCometBLSZKP)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "crypto/cometbls", "verifyZKP"), nReturns: 1}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

// ----- crypto/merkle.leafHash(leaf []byte) []byte -----

func benchMerkleLeafHash(b *testing.B, n int) {
	b.Helper()
	data := make([]byte, n)
	rand.Read(data)
	m := newDispatchMachine(1)
	setBlockValueFromGo(m, 0, data)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "crypto/merkle", "leafHash"), nReturns: 1}
	b.ResetTimer()
	b.SetBytes(int64(n))
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

func BenchmarkNative_Merkle_LeafHash_0(b *testing.B)     { benchMerkleLeafHash(b, 0) }
func BenchmarkNative_Merkle_LeafHash_64(b *testing.B)    { benchMerkleLeafHash(b, 64) }
func BenchmarkNative_Merkle_LeafHash_256(b *testing.B)   { benchMerkleLeafHash(b, 256) }
func BenchmarkNative_Merkle_LeafHash_1024(b *testing.B)  { benchMerkleLeafHash(b, 1024) }
func BenchmarkNative_Merkle_LeafHash_4096(b *testing.B)  { benchMerkleLeafHash(b, 4096) }
func BenchmarkNative_Merkle_LeafHash_16384(b *testing.B) { benchMerkleLeafHash(b, 16384) }

// ----- crypto/merkle.innerHash(left, right []byte) []byte -----
//
// Production call sites only ever pass 32-byte SHA256 outputs. Flat bench.

func BenchmarkNative_Merkle_InnerHash(b *testing.B) {
	left := make([]byte, 32)
	right := make([]byte, 32)
	rand.Read(left)
	rand.Read(right)
	m := newDispatchMachine(2)
	setBlockValueFromGo(m, 0, left)
	setBlockValueFromGo(m, 1, right)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "crypto/merkle", "innerHash"), nReturns: 1}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

// ----- crypto/merkle.hashFromByteSlices(encoded []byte) []byte -----
//
// Encoded layout: [4B count][4B len][data]*count. Cost scales with item count
// (~2·count - 1 SHA256s). We vary the item count at a fixed 32-byte item size
// (the realistic hash-of-hashes shape used by Tendermint); encoded length is
// 4 + count·(4+32) = 4 + 36·count, which is what the runtime slope reads.

func encodeByteSlicesForBench(items [][]byte) []byte {
	n := len(items)
	out := []byte{byte(n >> 24), byte(n >> 16), byte(n >> 8), byte(n)}
	for _, it := range items {
		l := len(it)
		out = append(out, byte(l>>24), byte(l>>16), byte(l>>8), byte(l))
		out = append(out, it...)
	}
	return out
}

func benchMerkleHashFromByteSlices(b *testing.B, count int) {
	b.Helper()
	items := make([][]byte, count)
	for i := range items {
		items[i] = make([]byte, 32)
		rand.Read(items[i])
	}
	encoded := encodeByteSlicesForBench(items)
	m := newDispatchMachine(1)
	setBlockValueFromGo(m, 0, encoded)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "crypto/merkle", "hashFromByteSlices"), nReturns: 1}
	b.ResetTimer()
	b.SetBytes(int64(len(encoded)))
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

func BenchmarkNative_Merkle_HashFromByteSlices_40(b *testing.B)  { benchMerkleHashFromByteSlices(b, 1) }
func BenchmarkNative_Merkle_HashFromByteSlices_148(b *testing.B) { benchMerkleHashFromByteSlices(b, 4) }
func BenchmarkNative_Merkle_HashFromByteSlices_580(b *testing.B) {
	benchMerkleHashFromByteSlices(b, 16)
}

func BenchmarkNative_Merkle_HashFromByteSlices_2308(b *testing.B) {
	benchMerkleHashFromByteSlices(b, 64)
}

func BenchmarkNative_Merkle_HashFromByteSlices_9220(b *testing.B) {
	benchMerkleHashFromByteSlices(b, 256)
}

func BenchmarkNative_Merkle_HashFromByteSlices_36868(b *testing.B) {
	benchMerkleHashFromByteSlices(b, 1024)
}

// ----- crypto/merkle.verifySimpleProof(rootHash, leaf, idx, total, aunts) bool -----
//
// Cost is dominated by ~log2(total) inner hashes. Aunts buffer is depth*32
// bytes, so we slope on len(aunts) (param idx 4). Bench uses balanced power-
// of-two trees so depth = log2(total).

func flattenAuntsBench(aunts [][]byte) []byte {
	out := make([]byte, 0, 32*len(aunts))
	for _, a := range aunts {
		out = append(out, a...)
	}
	return out
}

func benchMerkleVerifySimpleProof(b *testing.B, total int) {
	b.Helper()
	items := make([][]byte, total)
	for i := range items {
		items[i] = make([]byte, 32)
		rand.Read(items[i])
	}
	root, proofs := tmmerkle.SimpleProofsFromByteSlices(items)
	idx := total / 2
	leaf := items[idx]
	aunts := flattenAuntsBench(proofs[idx].Aunts)
	m := newDispatchMachine(5)
	setBlockValueFromGo(m, 0, root)
	setBlockValueFromGo(m, 1, leaf)
	setBlockValueFromGo(m, 2, idx)
	setBlockValueFromGo(m, 3, total)
	setBlockValueFromGo(m, 4, aunts)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "crypto/merkle", "verifySimpleProof"), nReturns: 1}
	b.ResetTimer()
	b.SetBytes(int64(len(aunts)))
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

func BenchmarkNative_Merkle_VerifySimpleProof_32(b *testing.B)  { benchMerkleVerifySimpleProof(b, 2) }
func BenchmarkNative_Merkle_VerifySimpleProof_64(b *testing.B)  { benchMerkleVerifySimpleProof(b, 4) }
func BenchmarkNative_Merkle_VerifySimpleProof_128(b *testing.B) { benchMerkleVerifySimpleProof(b, 16) }
func BenchmarkNative_Merkle_VerifySimpleProof_192(b *testing.B) { benchMerkleVerifySimpleProof(b, 64) }
func BenchmarkNative_Merkle_VerifySimpleProof_256(b *testing.B) { benchMerkleVerifySimpleProof(b, 256) }
func BenchmarkNative_Merkle_VerifySimpleProof_320(b *testing.B) {
	benchMerkleVerifySimpleProof(b, 1024)
}

// ----- crypto/modexp.modExp(base, exp, modulus []byte) []byte -----
//
// Modulus held at 256 bytes (RSA-2048 worst case) so a single linear slope
// on len(exp) captures cost. exp = all-bits-set forces full work per round.
// See native_gas.go for the safety trade-off this shape implies.
var modexpFixedModulus256 = func() []byte {
	out := make([]byte, 256)
	for i := range out {
		out[i] = 0xFF
	}
	// Last byte = 0xFD so modulus is odd (Exp short-circuits to 0 for even mods
	// with no precomputed Mont form; we want the slow path).
	out[255] = 0xFD
	return out
}()

func benchModExp(b *testing.B, expLen int) {
	b.Helper()
	exp := make([]byte, expLen)
	for i := range exp {
		exp[i] = 0xFF
	}
	base := make([]byte, 256)
	rand.Read(base)
	m := newDispatchMachine(3)
	setBlockValueFromGo(m, 0, base)
	setBlockValueFromGo(m, 1, exp)
	setBlockValueFromGo(m, 2, modexpFixedModulus256)
	h := &dispatchHarness{m: m, wrapper: resolveWrapper(b, "crypto/modexp", "modExp"), nReturns: 1}
	b.ResetTimer()
	b.SetBytes(int64(expLen))
	for i := 0; i < b.N; i++ {
		h.call()
	}
}

func BenchmarkNative_Modexp_1(b *testing.B)   { benchModExp(b, 1) }
func BenchmarkNative_Modexp_8(b *testing.B)   { benchModExp(b, 8) }
func BenchmarkNative_Modexp_32(b *testing.B)  { benchModExp(b, 32) }
func BenchmarkNative_Modexp_64(b *testing.B)  { benchModExp(b, 64) }
func BenchmarkNative_Modexp_128(b *testing.B) { benchModExp(b, 128) }
