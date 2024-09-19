// internal and external incentive + warm up period testing
// with two external incentives for same pool
// 	bar + gns
// with internal incentive for same pool

package staker

import (
	"std"
	"testing"
	"time"

	u256 "gno.land/p/gnoswap/uint256"

	"gno.land/r/gnoswap/v2/consts"

	en "gno.land/r/gnoswap/v2/emission"
	pl "gno.land/r/gnoswap/v2/pool"
	pn "gno.land/r/gnoswap/v2/position"

	"gno.land/r/gnoswap/v2/gnft"
	"gno.land/r/gnoswap/v2/gns"

	"gno.land/r/onbloc/bar"
	"gno.land/r/onbloc/qux"
)

func init() {
	// init pool tiers
	// tier 1
	delete(poolTiers, MUST_EXISTS_IN_TIER_1)
	poolTiers["gno.land/r/onbloc/bar:gno.land/r/onbloc/qux:100"] = InternalTier{
		tier:           1,
		startTimestamp: time.Now().Unix(),
	}

	// override warm-up period for testing
	warmUp[100] = 901 // 30m ~
	warmUp[70] = 301  // 10m ~ 30m
	warmUp[50] = 151  // 5m ~ 10m
	warmUp[30] = 1    // ~ 5m
}

func TestPoolInitCreatePool(t *testing.T) {

	std.TestSetOrigCaller(gsa)
	std.TestSetRealm(gsaRealm)

	gns.Approve(a2u(consts.POOL_ADDR), pl.GetPoolCreationFee()*3)

	pl.CreatePool(barPath, quxPath, 100, "79228162514264337593543950337")
	pl.CreatePool(barPath, bazPath, 3000, "79228162514264337593543950337")

	std.TestSkipHeights(1)
}

func TestMintBarQux100_1(t *testing.T) {
	std.TestSetOrigCaller(gsa)
	std.TestSetRealm(gsaRealm)

	bar.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)
	qux.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)

	tokenId, liquidity, amount0, amount1 := pn.Mint(
		barPath,      // token0
		quxPath,      // token1
		fee100,       // fee
		int32(-1000), // tickLower
		int32(1000),  // tickUpper
		"63",         // amount0Desired
		"63",         // amount1Desired
		"1",          // amount0Min
		"1",          // amount1Min
		max_timeout,
		gsa.String(),
	)

	shouldEQ(t, tokenId, uint64(1))
	shouldEQ(t, gnft.OwnerOf(tid(tokenId)), std.GetOrigCaller()) // gsa

	std.TestSkipHeights(1)
}

func TestMintBarQux100_2(t *testing.T) {
	std.TestSetOrigCaller(gsa)
	std.TestSetRealm(gsaRealm)

	bar.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)
	qux.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)

	tokenId, liquidity, amount0, amount1 := pn.Mint(
		barPath,      // token0
		quxPath,      // token1
		fee100,       // fee
		int32(-1000), // tickLower
		int32(1000),  // tickUpper
		"980",        // amount0Desired
		"980",        // amount1Desired
		"1",          // amount0Min
		"1",          // amount1Min
		max_timeout,
		gsa.String(),
	)

	shouldEQ(t, tokenId, uint64(2))
	shouldEQ(t, gnft.OwnerOf(tid(tokenId)), std.GetOrigCaller()) // gsa

	std.TestSkipHeights(1)
}

func TestMintBarQux100_3(t *testing.T) {
	std.TestSetOrigCaller(gsa)
	std.TestSetRealm(gsaRealm)

	bar.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)
	qux.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)

	tokenId, liquidity, amount0, amount1 := pn.Mint(
		barPath,      // token0
		quxPath,      // token1
		fee100,       // fee
		int32(-1000), // tickLower
		int32(1000),  // tickUpper
		"73290",      // amount0Desired
		"73290",      // amount1Desired
		"1",          // amount0Min
		"1",          // amount1Min
		max_timeout,
		gsa.String(),
	)

	shouldEQ(t, tokenId, uint64(3))
	shouldEQ(t, gnft.OwnerOf(tid(tokenId)), std.GetOrigCaller()) // gsa

	std.TestSkipHeights(1)
}

func TestMintBarQux100_4(t *testing.T) {
	std.TestSetOrigCaller(gsa)
	std.TestSetRealm(gsaRealm)

	bar.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)
	qux.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)

	tokenId, liquidity, amount0, amount1 := pn.Mint(
		barPath,      // token0
		quxPath,      // token1
		fee100,       // fee
		int32(-1000), // tickLower
		int32(1000),  // tickUpper
		"23780",      // amount0Desired
		"23780",      // amount1Desired
		"1",          // amount0Min
		"1",          // amount1Min
		max_timeout,
		gsa.String(),
	)

	shouldEQ(t, tokenId, uint64(4))
	shouldEQ(t, gnft.OwnerOf(tid(tokenId)), std.GetOrigCaller()) // gsa

	std.TestSkipHeights(1)
}

func TestMintBarQux100_5(t *testing.T) {
	std.TestSetOrigCaller(gsa)
	std.TestSetRealm(gsaRealm)

	bar.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)
	qux.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)

	tokenId, liquidity, amount0, amount1 := pn.Mint(
		barPath,      // token0
		quxPath,      // token1
		fee100,       // fee
		int32(-1000), // tickLower
		int32(1000),  // tickUpper
		"1870",       // amount0Desired
		"1870",       // amount1Desired
		"1",          // amount0Min
		"1",          // amount1Min
		max_timeout,
		gsa.String(),
	)

	shouldEQ(t, tokenId, uint64(5))
	shouldEQ(t, gnft.OwnerOf(tid(tokenId)), std.GetOrigCaller()) // gsa

	std.TestSkipHeights(1)
}

func TestCreateExternalIncentiveBar(t *testing.T) {
	std.TestSetOrigCaller(gsa)
	std.TestSetRealm(gsaRealm)

	bar.Approve(a2u(consts.STAKER_ADDR), consts.UINT64_MAX)
	gns.Approve(a2u(consts.STAKER_ADDR), depositGnsAmount)

	CreateExternalIncentive(
		"gno.land/r/onbloc/bar:gno.land/r/onbloc/qux:100", // targetPoolPath string,
		barPath,     // rewardToken string, // token path should be registered
		"250000000", // _rewardAmount string,
		1234569600,
		1234569600+TIMESTAMP_90DAYS,
	)

	// after
	printExternalInfo()

	std.TestSkipHeights(1)
}

func TestCreateExternalIncentiveGns(t *testing.T) {
	std.TestSetOrigCaller(gsa)
	std.TestSetRealm(gsaRealm)

	gns.Approve(a2u(consts.STAKER_ADDR), consts.UINT64_MAX) // this includes depositGnsAmount

	CreateExternalIncentive(
		"gno.land/r/onbloc/bar:gno.land/r/onbloc/qux:100", // targetPoolPath string,
		consts.GNS_PATH, // rewardToken string, // token path should be registered
		"1000000000000", // _rewardAmount string,
		1234569600,
		1234569600+TIMESTAMP_90DAYS,
	)

	// after
	printExternalInfo()

	std.TestSkipHeights(1)
}

func TestStakeToken_1_5(t *testing.T) {
	std.TestSetOrigCaller(gsa)
	std.TestSetRealm(gsaRealm)

	gnft.Approve(a2u(GetOrigPkgAddr()), tid(1))
	StakeToken(1)

	gnft.Approve(a2u(GetOrigPkgAddr()), tid(2))
	StakeToken(2)

	gnft.Approve(a2u(GetOrigPkgAddr()), tid(3))
	StakeToken(3)

	gnft.Approve(a2u(GetOrigPkgAddr()), tid(4))
	StakeToken(4)

	gnft.Approve(a2u(GetOrigPkgAddr()), tid(5))
	StakeToken(5)

	std.TestSkipHeights(1)
}

func TestBeforeActive(t *testing.T) {
	en.MintAndDistributeGns()
	CalcPoolPosition()
	printExternalInfo()

	std.TestSkipHeights(1)
}

func TestLiquidity(t *testing.T) {
	pos1Liq := pn.PositionGetPositionLiquidity(1)
	pos2Liq := pn.PositionGetPositionLiquidity(2)
	pos3Liq := pn.PositionGetPositionLiquidity(3)
	pos4Liq := pn.PositionGetPositionLiquidity(4)
	pos5Liq := pn.PositionGetPositionLiquidity(5)

	all := u256.Zero()
	all.Add(all, pos1Liq)
	all.Add(all, pos2Liq)
	all.Add(all, pos3Liq)
	all.Add(all, pos4Liq)
	all.Add(all, pos5Liq)

	/*
		pos1Liq 1291			// 1291 / 2050165 = 0.0006297054
		pos2Liq 20095			// 20095 / 2050165 = 0.0098016501
		pos3Liq 1502823 	// 1502823 / 2050165 = 0.7330253906
		pos4Liq 487612 		// 487612 / 2050165 = 0.2378403689
		pos5Liq 38344 		// 38344 / 2050165 = 0.0187028849
		all 2050165
	*/

}

func TestAfterActive(t *testing.T) {
	std.TestSkipHeights(849)   // in active
	std.TestSkipHeights(1)     // active // but no block passed since active
	std.TestSkipHeights(12600) // skip 12600 = 25200s = 7h

	en.MintAndDistributeGns()
	CalcPoolPosition()

	t.Run("position #1", func(t *testing.T) {
		CollectReward(1, false)
		// ext - bar
		// - full 509
		// - give 494
		// - user 490
		// user / full * 100 = 96.2671905697

		// ext - gns
		// - full 2041519
		// - give 1983213
		// - user 1963381
		// user / full * 100  = 96.1725558273

		// int - emission
		// - full 90654871
		// - give 88228781
		// - user 87346494
		// user / full * 100 = 96.3505799926
	})

	t.Run("position #2", func(t *testing.T) {
		CollectReward(2, false)
		// ext - bar
		// - full 7943
		// - give 7716
		// - user 7639
		// user / full * 100 = 96.1727307063

		// ext - gns
		// - full 31777211
		// - give 30869651
		// - user 30560955
		// user / full * 100  = 96.172552714

		// int - emission
		// - full 1411085101
		// - give 1373321896
		// - user 1359588678
		// user / full * 100 = 96.3505799215
	})

	t.Run("position #3", func(t *testing.T) {
		CollectReward(3, false)
		// ext - bar
		// - full 594121
		// - give 577153
		// - user 571382
		// user / full * 100 = 96.1726651642

		// ext - gns
		// - full 2376487920
		// - give 2308615199
		// - user 2285529048
		// user / full * 100  = 96.1725506267

		// int - emission
		// - full 105529294467
		// - give 102705138503
		// - user 101678087118
		// user / full * 100 = 96.3505798381
	})

	t.Run("position #4", func(t *testing.T) {
		CollectReward(4, false)
		// ext - bar
		// - full 192768
		// - give 187264
		// - user 185392
		// user / full * 100 = 96.1736387782

		// ext - gns
		// - full 771084834
		// - give 749062578
		// - user 741571953
		// user / full * 100  = 96.1725507105

		// int - emission
		// - full 34240459569
		// - give 33324122559
		// - user 32990881334
		// user / full * 100 = 96.3505798382
	})

	t.Run("position #5", func(t *testing.T) {
		CollectReward(5, false)
		// ext - bar
		// - full 15157
		// - give 14725
		// - user 14578
		// user / full * 100 = 96.1799828462

		// ext - gns
		// - full 60635247
		// - give 58903499
		// - user 58314465
		// user / full * 100  = 96.1725529047

		// int - emission
		// - full 2692542684
		// - give 2620485341
		// - user 2594280488
		// user / full * 100 = 96.3505798224
	})

}
