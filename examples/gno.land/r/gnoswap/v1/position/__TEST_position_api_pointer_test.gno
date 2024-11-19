package position

import (
	"std"
	"testing"

	"gno.land/r/gnoswap/v1/common"
	"gno.land/r/gnoswap/v1/consts"

	"gno.land/r/gnoswap/v1/gnft"
	"gno.land/r/gnoswap/v1/gns"
	"gno.land/r/onbloc/bar"
	"gno.land/r/onbloc/foo"

	pl "gno.land/r/gnoswap/v1/pool"
	sr "gno.land/r/gnoswap/v1/staker"
)

func init() {
	// set pool create fee to 0 for testing
	std.TestSetRealm(adminRealm)
	pl.SetPoolCreationFeeByAdmin(0)
}

func TestPoolInitCreatePool(t *testing.T) {
	std.TestSetRealm(adminRealm)

	gns.Approve(a2u(consts.POOL_ADDR), pl.GetPoolCreationFee())
	pl.CreatePool(barPath, fooPath, fee500, common.TickMathGetSqrtRatioAtTick(-10000).ToString())
	pl.CreatePool(bazPath, quxPath, fee500, "130621891405341611593710811006") // tick = 10000
}

func TestMintFooBar(t *testing.T) {
	std.TestSetRealm(adminRealm)
	foo.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)
	bar.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)

	// admin mints => will get tid 1 nft
	Mint(fooPath, barPath, fee500, int32(9000), int32(11000), "1000000", "1000000", "1", "1", max_timeout, admin, admin)
}

func TestLiquidityPointer(t *testing.T) {
	{
		// minted
		lp1 := positions[1]
		liq := lp1.liquidity.ToString()
		if liq != "12437322" {
			t.Fatalf("Expected liquidity to be 12437322, got %s", liq)
		}
	}

	{
		std.TestSetRealm(adminRealm)
		// set pool as internal target
		sr.SetPoolTierByAdmin("gno.land/r/onbloc/bar:gno.land/r/onbloc/foo:500", 1)

		// stake
		gnft.Approve(a2u(consts.STAKER_ADDR), "1")
		std.TestSkipHeights(1)

		sr.StakeToken(uint64(1))
		std.TestSkipHeights(1)

		lp1 := positions[1]
		liq := lp1.liquidity.ToString()
		if liq != "12437322" {
			t.Fatalf("Expected liquidity to be 12437322, got %s", liq)
		}
	}

	{
		// unstake
		std.TestSetRealm(adminRealm)
		sr.UnstakeToken(uint64(1), false)
		std.TestSkipHeights(1)

		lp1 := positions[1]
		liq := lp1.liquidity.ToString()
		if liq != "12437322" {
			t.Fatalf("Expected liquidity to be 12437322, got %s", liq)
		}
	}
}
