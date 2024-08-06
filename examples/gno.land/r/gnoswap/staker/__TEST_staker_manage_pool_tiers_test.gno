package staker

import (
	"std"
	"testing"

	pl "gno.land/r/gnoswap/pool"

	"gno.land/r/gnoswap/consts"

	"gno.land/r/gnoswap/gns"
)

func TestPoolInitCreatePool(t *testing.T) {
	std.TestSetRealm(gsaRealm)

	gns.Approve(a2u(consts.POOL_ADDR), pl.GetPoolCreationFee())
	std.TestSkipHeights(1)

	pl.CreatePool(fooPath, barPath, 500, "130621891405341611593710811006") // tick 10_000 ≈ x2.7

	std.TestSkipHeights(1)
}

func TestSetPoolTier(t *testing.T) {
	std.TestSetOrigCaller(consts.GNOSWAP_ADMIN)
	SetPoolTier("gno.land/r/onbloc/bar:gno.land/r/onbloc/foo:500", 2)

	if poolTiers["gno.land/r/onbloc/bar:gno.land/r/onbloc/foo:500"].tier != 2 {
		t.Error("Expected tier to be 2")
	}
}

func TestGetPoolsWithTierStruct(t *testing.T) {
	poolTiers := GetPoolsWithTierStruct()
	if len(poolTiers) != 2 {
		t.Error("Expected 2 pools")
	}
}

func TestChangePoolTier(t *testing.T) {
	std.TestSetOrigCaller(consts.GNOSWAP_ADMIN)
	ChangePoolTier("gno.land/r/onbloc/bar:gno.land/r/onbloc/foo:500", 3)

	if poolTiers["gno.land/r/onbloc/bar:gno.land/r/onbloc/foo:500"].tier != 3 {
		t.Error("Expected tier to be 3")
	}
}

func TestGetPoolsWithTier(t *testing.T) {
	poolTiers := GetPoolsWithTier()
	shouldEQ(t, len(poolTiers), 2)
	shouldEQ(t, poolTiers[0], "gno.land/r/demo/wugnot:gno.land/r/gnoswap/gns:3000_1")
	shouldEQ(t, poolTiers[1], "gno.land/r/onbloc/bar:gno.land/r/onbloc/foo:500_3")
}

func TestRemovePoolTier(t *testing.T) {
	std.TestSetOrigCaller(consts.GNOSWAP_ADMIN)
	RemovePoolTier("gno.land/r/onbloc/bar:gno.land/r/onbloc/foo:500")

	if len(poolTiers) != 1 {
		t.Error("Expected 1 pool")
	}
}

func TestGetPoolsWithTierAfterRemove(t *testing.T) {
	poolTiers := GetPoolsWithTier()
	shouldEQ(t, len(poolTiers), 1)
	shouldEQ(t, poolTiers[0], "gno.land/r/demo/wugnot:gno.land/r/gnoswap/gns:3000_1")
}
