// ---       runtime: cycle=13.0k imports=20 allocs=931.6k(0.19%)
// ---       runtime: cycle=17.1k imports=20 allocs=1.0M(0.21%)
// ---       runtime: cycle=21.9k imports=20 allocs=1.2M(0.23%)
// ---       runtime: cycle=22.4k imports=20 allocs=1.2M(0.24%)
// ---       runtime: cycle=23.0k imports=20 allocs=1.3M(0.25%)
// ok      ./examples/gno.land/r/gnoswap/v2/protocol_fee 	1.09s

package protocol_fee

import (
	"std"
	"testing"

	"gno.land/r/onbloc/bar"
	"gno.land/r/onbloc/qux"

	pusers "gno.land/p/demo/users"

	"gno.land/r/gnoswap/v2/consts"

	"gno.land/p/demo/testutils"
)

func TestDistributeProtocolFee(t *testing.T) {
	// admin > protocol_fee
	// send qux, bar for testing
	std.TestSetRealm(gsaRealm)
	bar.Transfer(a2u(consts.PROTOCOL_FEE_ADDR), 1000)
	qux.Transfer(a2u(consts.PROTOCOL_FEE_ADDR), 1000)

	shouldEQ(t, bar.BalanceOf(a2u(consts.PROTOCOL_FEE_ADDR)), 1000)
	shouldEQ(t, bar.BalanceOf(a2u(consts.DEV_OPS)), 0)
	shouldEQ(t, bar.BalanceOf(a2u(consts.X_GNS_ADDR)), 0)

	shouldEQ(t, qux.BalanceOf(a2u(consts.PROTOCOL_FEE_ADDR)), 1000)
	shouldEQ(t, qux.BalanceOf(a2u(consts.DEV_OPS)), 0)
	shouldEQ(t, qux.BalanceOf(a2u(consts.X_GNS_ADDR)), 0)

	DistributeProtocolFee()

	shouldEQ(t, bar.BalanceOf(a2u(consts.PROTOCOL_FEE_ADDR)), 0)
	shouldEQ(t, bar.BalanceOf(a2u(consts.DEV_OPS)), 500)
	shouldEQ(t, bar.BalanceOf(a2u(consts.X_GNS_ADDR)), 500)

	shouldEQ(t, qux.BalanceOf(a2u(consts.PROTOCOL_FEE_ADDR)), 0)
	shouldEQ(t, qux.BalanceOf(a2u(consts.DEV_OPS)), 500)
	shouldEQ(t, qux.BalanceOf(a2u(consts.X_GNS_ADDR)), 500)
}

func TestDistributeProtocolFeeNoPermission(t *testing.T) {
	dummy := testutils.TestAddress("dummy")
	dummyRealm := std.NewUserRealm(dummy)
	std.TestSetRealm(dummyRealm)

	shouldPanicWithMsg(
		t,
		func() {
			DistributeProtocolFee()
		},
		"only admin(g1lmvrrrr4er2us84h2732sru76c9zl2nvknha8c) or governance(g1cu4dufdlzu0l9pekkqhw6mjnrxkp3z7ykst09d) can distribute protocol fee, called from g1v36k6mteta047h6lta047h6lta047h6lz7gmv8",
	)
}

func TestChagneXGnsDistributePercentNoPermission(t *testing.T) {
	dummy := testutils.TestAddress("dummy")
	dummyRealm := std.NewUserRealm(dummy)
	std.TestSetRealm(dummyRealm)

	shouldPanicWithMsg(
		t,
		func() {
			ChagneXGnsDistributePercent(123)
		},
		"only admin(g1lmvrrrr4er2us84h2732sru76c9zl2nvknha8c) or governance(g1cu4dufdlzu0l9pekkqhw6mjnrxkp3z7ykst09d) can change protocol fee distribution percent, called from g1v36k6mteta047h6lta047h6lta047h6lz7gmv8",
	)
}

func TestChagneXGnsDistributePercentInvalidFee(t *testing.T) {
	std.TestSetRealm(gsaRealm)

	shouldPanicWithMsg(
		t,
		func() {
			ChagneXGnsDistributePercent(100001)
		},
		"fee should be less than 10000",
	)
}

func TestChagneXGnsDistributePercent(t *testing.T) {
	std.TestSetRealm(gsaRealm)

	shouldEQ(t, GetXGnsDistributePercent(), 5000)

	ChagneXGnsDistributePercent(123)

	shouldEQ(t, GetXGnsDistributePercent(), 123)
}

func a2u(addr std.Address) pusers.AddressOrName {
	return pusers.AddressOrName(addr)
}

func shouldPanicWithMsg(t *testing.T, f func(), msg string) {
	defer func() {
		if r := recover(); r == nil {
			t.Errorf("The code did not panic")
		} else {
			if r != msg {
				t.Errorf("excepted panic(%v), got(%v)", msg, r)
			}
		}
	}()
	f()
}
