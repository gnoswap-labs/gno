// ---       runtime: cycle=1.7k imports=6 allocs=110.7k(0.02%)
// ---       runtime: cycle=5.9k imports=6 allocs=212.2k(0.04%)
// ---       runtime: cycle=11.2k imports=6 allocs=361.4k(0.07%)
// ---       runtime: cycle=250.4k imports=6 allocs=6.9M(1.37%)
// ---       runtime: cycle=379.0k imports=6 allocs=10.6M(2.12%)
// ---       runtime: cycle=586.1k imports=6 allocs=15.3M(3.07%)
// ---       runtime: cycle=832.2k imports=6 allocs=20.9M(4.18%)
// ---       runtime: cycle=1.5M imports=6 allocs=48.7M(9.75%)
// ---       runtime: cycle=1.5M imports=6 allocs=48.8M(9.75%)
// ---       runtime: cycle=1.5M imports=6 allocs=48.9M(9.79%)
// ---       runtime: cycle=1.5M imports=6 allocs=49.0M(9.81%)
// ---       runtime: cycle=1.5M imports=6 allocs=49.1M(9.82%)
// ---       runtime: cycle=1.5M imports=6 allocs=49.1M(9.83%)
// ---       runtime: cycle=1.5M imports=6 allocs=49.3M(9.86%)
// ---       runtime: cycle=1.5M imports=6 allocs=49.4M(9.87%)
// ok      ./examples/gno.land/r/gnoswap/v2/pool 	1.40s

package pool

import (
	"std"
	"testing"

	"gno.land/p/demo/json"

	"gno.land/r/onbloc/bar"
	"gno.land/r/onbloc/baz"
	"gno.land/r/onbloc/foo"

	"gno.land/r/gnoswap/v2/consts"

	"gno.land/r/gnoswap/v2/gns"

	"gno.land/p/demo/testutils"
)

var (
	test_tickLower          = int32(9000)
	test_tickUpper          = int32(11000)
	test_liquidityExpectStr = "100000000"
)

// 1. Create Foo:Bar Pool
func TestCreateFooBarPool(t *testing.T) {
	// call gns faucet to get creation fee
	std.TestSetRealm(gsaRealm)

	std.TestSkipHeights(5)

	gns.Approve(a2u(consts.POOL_ADDR), poolCreationFee)
	std.TestSkipHeights(1)

	CreatePool(fooPath, barPath, fee500, "130621891405341611593710811006") // tick 10000
	// ---       event: {GNOSWAP gno.land/r/gnoswap/v2/pool CreatePool [{m_callType DIRECT} {m_origCaller g1lmvrrrr4er2us84h2732sru76c9zl2nvknha8c} {m_prevRealm } {p_poolPath gno.land/r/onbloc/bar:gno.land/r/onbloc/foo:500}]}

	shouldEQ(t, len(pools), 1)
	std.TestSkipHeights(1)
}

// 2. Create Bar:Baz Pool
func TestCreateBarBazPool(t *testing.T) {
	// call gns faucet to get creation fee
	std.TestSetRealm(gsaRealm)
	std.TestSetRealm(gsaRealm)

	std.TestSkipHeights(5)

	gns.Approve(a2u(consts.POOL_ADDR), poolCreationFee)
	std.TestSkipHeights(1)

	CreatePool(barPath, bazPath, fee500, "130621891405341611593710811006") // tick 10000
	// ---       event: {GNOSWAP gno.land/r/gnoswap/v2/pool CreatePool [{m_callType DIRECT} {m_origCaller g1lmvrrrr4er2us84h2732sru76c9zl2nvknha8c} {m_prevRealm } {p_poolPath gno.land/r/onbloc/bar:gno.land/r/onbloc/baz:500}]}

	shouldEQ(t, len(pools), 2)
	std.TestSkipHeights(1)
}

// 3. Mint Foo:Bar Liquidity by gsa
func TestMintFooBarLiquidity(t *testing.T) {
	std.TestSetRealm(gsaRealm)
	foo.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)
	bar.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)
	std.TestSkipHeights(4)

	std.TestSetRealm(posRealm)
	std.TestSetOrigCaller(gsa)
	amount0, amount1 := Mint(
		barPath,
		fooPath,
		fee500,
		consts.POSITION_ADDR.String(),
		-11000, // -11000
		-9000,  // -9000
		test_liquidityExpectStr,
	)
	shouldEQ(t, amount0, "8040316")
	shouldEQ(t, amount1, "2958015")
	std.TestSkipHeights(1)
}

// 4. Mint Bar:Baz Liquidity by gsa
func TestMintBarBazLiquidity(t *testing.T) {
	std.TestSetRealm(gsaRealm)
	bar.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)
	baz.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)
	std.TestSkipHeights(2)

	std.TestSetRealm(posRealm)
	std.TestSetOrigCaller(gsa)
	amount0, amount1 := Mint(
		barPath,
		bazPath,
		fee500,
		consts.POSITION_ADDR.String(),
		test_tickLower,
		test_tickUpper,
		test_liquidityExpectStr,
	)
	shouldEQ(t, amount0, "2958015")
	shouldEQ(t, amount1, "8040316")
	std.TestSkipHeights(1)
}

// GETTER_API TEST
func TestApiGetPools(t *testing.T) {
	gpls := ApiGetPools()

	root, err := json.Unmarshal([]byte(gpls))
	if err != nil {
		panic(err)
	}

	response, err := root.GetKey("response")
	if err != nil {
		panic(err)
	}

	shouldEQ(t, response.Size(), 2)
}

// Test Getter/Setter for WithdrawalFee
func TestGetWithdrawalFee(t *testing.T) {
	shouldEQ(t, GetWithdrawalFee(), uint64(100))
}

func TestSetWithdrawalFeeNoPermission(t *testing.T) {
	dummy := testutils.TestAddress("dummy")
	std.TestSetOrigCaller(dummy)

	shouldPanicWithMsg(
		t,
		func() {
			SetWithdrawalFee(2)
		},
		"[POOL] protocol_fee_withdrawal.gno__SetWithdrawalFee() || only admin(g1lmvrrrr4er2us84h2732sru76c9zl2nvknha8c) or governance(g1cu4dufdlzu0l9pekkqhw6mjnrxkp3z7ykst09d) can set withdrawal fee, called from g1v36k6mteta047h6lta047h6lta047h6lz7gmv8",
	)
}

func TestSetWithdrawalFeeFeeOutOfRange(t *testing.T) {
	std.TestSetOrigCaller(gsa)

	shouldPanicWithMsg(
		t,
		func() {
			SetWithdrawalFee(10001)
		},
		"[POOL] withdrawal_fee.gno__SetWithdrawalFee() || fee(10001) must be in range 0 ~ 10000",
	)
}

func TestSetWithdrawalFee(t *testing.T) {
	std.TestSetOrigCaller(gsa)
	shouldEQ(t, GetWithdrawalFee(), uint64(100))
	SetWithdrawalFee(300)
	shouldEQ(t, GetWithdrawalFee(), uint64(300))
}

// Test Getter/Setter for PoolCreationFee
func TestGetPoolCreationFee(t *testing.T) {
	shouldEQ(t, GetPoolCreationFee(), uint64(100_000_000))
}

func TestSetPoolCreationFeeNoPermission(t *testing.T) {
	dummy := testutils.TestAddress("dummy")
	std.TestSetOrigCaller(dummy)

	shouldPanicWithMsg(
		t,
		func() {
			SetPoolCreationFee(2)
		},
		"[POOL] protocol_fee_pool_creation.gno__SetPoolCreationFee() || only admin(g1lmvrrrr4er2us84h2732sru76c9zl2nvknha8c) or governance(g1cu4dufdlzu0l9pekkqhw6mjnrxkp3z7ykst09d) can set pool creation fee, called from g1v36k6mteta047h6lta047h6lta047h6lz7gmv8",
	)
}

func TestSetPoolCreationFee(t *testing.T) {
	std.TestSetOrigCaller(gsa)
	shouldEQ(t, GetPoolCreationFee(), uint64(100_000_000))
	SetPoolCreationFee(200_000_000)
	shouldEQ(t, GetPoolCreationFee(), uint64(200_000_000))
}
