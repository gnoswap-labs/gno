// Gas and performance metrics for multi-hop and multi-route stress test
// Tests: 2 hops, 3 hops, and multi-route (split across multiple paths)
// Uses gns, wugnot, obl, and bar tokens
package main

import (
	"chain"
	"testing"

	prabc "gno.land/p/gnoswap/rbac"
	_ "gno.land/r/gnoswap/rbac"

	_ "gno.land/r/gnoswap/pool/v1"
	_ "gno.land/r/gnoswap/position/v1"
	_ "gno.land/r/gnoswap/protocol_fee/v1"
	_ "gno.land/r/gnoswap/router/v1"
	_ "gno.land/r/gnoswap/staker/v1"

	"gno.land/r/gnoswap/access"
	"gno.land/r/gnoswap/common"
	"gno.land/r/gnoswap/gns"
	"gno.land/r/gnoswap/pool"
	"gno.land/r/gnoswap/position"
	"gno.land/r/gnoswap/router"

	"gno.land/r/gnoland/wugnot"
	"gno.land/r/onbloc/bar"
	"gno.land/r/onbloc/obl"

	"gno.land/r/gnoswap/scenario/metric"
)

var (
	adminAddr, _ = access.GetAddress(prabc.ROLE_ADMIN.String())
	adminRealm   = testing.NewUserRealm(adminAddr)

	poolAddr, _   = access.GetAddress(prabc.ROLE_POOL.String())
	routerAddr, _ = access.GetAddress(prabc.ROLE_ROUTER.String())

	wugnotPath = "gno.land/r/gnoland/wugnot"
	gnsPath    = "gno.land/r/gnoswap/gns"
	oblPath    = "gno.land/r/onbloc/obl"
	barPath    = "gno.land/r/onbloc/bar"

	maxInt64 int64 = 9223372036854775807
)

var t *testing.T

func main() {
	initializeSetup()
	testing.SetRealm(adminRealm)
	testing.SetOriginSend(chain.Coins{{"ugnot", 100000000000000}})
	wugnot.Deposit(cross)
	testing.SetOriginSend(chain.Coins{})
	createPools()
	mintPositions()

	// 2 hops: gns -> obl -> wugnot
	doubleHopExactIn()
	doubleHopExactOut()

	// 3 hops: gns -> obl -> bar -> wugnot
	tripleHopExactIn()
	tripleHopExactOut()

	// Multi-route: 50% direct (gns -> wugnot) + 50% via obl (gns -> obl -> wugnot)
	multiRouteExactIn()
	multiRouteExactOut()
}

func initializeSetup() {
	testing.SetRealm(adminRealm)
	pool.SetPoolCreationFee(cross, 0)

	testing.IssueCoins(chain.PackageAddress("gno.land/r/gnoland/wugnot"), chain.Coins{{"ugnot", 100000000000000}})
	testing.IssueCoins(adminAddr, chain.Coins{{"ugnot", 100000000000000}})

	gns.Approve(cross, poolAddr, maxInt64)
	wugnot.Approve(cross, poolAddr, maxInt64)
	obl.Approve(cross, poolAddr, maxInt64)
	bar.Approve(cross, poolAddr, maxInt64)
	gns.Approve(cross, routerAddr, maxInt64)
	wugnot.Approve(cross, routerAddr, maxInt64)
	obl.Approve(cross, routerAddr, maxInt64)
	bar.Approve(cross, routerAddr, maxInt64)
}

func createPools() {
	testing.SetRealm(adminRealm)

	// Pool 1: gns <-> wugnot (for direct route)
	pool.CreatePool(
		cross,
		wugnotPath,
		gnsPath,
		3000,
		common.TickMathGetSqrtRatioAtTick(0).ToString(),
	)

	// Pool 2: gns <-> obl
	pool.CreatePool(
		cross,
		gnsPath,
		oblPath,
		3000,
		common.TickMathGetSqrtRatioAtTick(0).ToString(),
	)

	// Pool 3: obl <-> wugnot
	pool.CreatePool(
		cross,
		wugnotPath,
		oblPath,
		3000,
		common.TickMathGetSqrtRatioAtTick(0).ToString(),
	)

	// Pool 4: obl <-> bar (for 3-hop)
	pool.CreatePool(
		cross,
		oblPath,
		barPath,
		3000,
		common.TickMathGetSqrtRatioAtTick(0).ToString(),
	)

	// Pool 5: bar <-> wugnot (for 3-hop)
	pool.CreatePool(
		cross,
		wugnotPath,
		barPath,
		3000,
		common.TickMathGetSqrtRatioAtTick(0).ToString(),
	)
}

func mintPositions() {
	testing.SetRealm(adminRealm)
	testing.SetOriginSend(chain.Coins{})

	// Mint position for gns <-> wugnot pool
	position.Mint(
		cross,
		wugnotPath,
		gnsPath,
		3000,
		-887220,
		887220,
		"1000000000",
		"1000000000",
		"0",
		"0",
		9999999999,
		adminAddr,
		adminAddr,
		"",
	)

	// Mint position for gns <-> obl pool
	position.Mint(
		cross,
		gnsPath,
		oblPath,
		3000,
		-887220,
		887220,
		"1000000000",
		"1000000000",
		"0",
		"0",
		9999999999,
		adminAddr,
		adminAddr,
		"",
	)

	// Mint position for obl <-> wugnot pool
	position.Mint(
		cross,
		wugnotPath,
		oblPath,
		3000,
		-887220,
		887220,
		"1000000000",
		"1000000000",
		"0",
		"0",
		9999999999,
		adminAddr,
		adminAddr,
		"",
	)

	// Mint position for obl <-> bar pool
	position.Mint(
		cross,
		oblPath,
		barPath,
		3000,
		-887220,
		887220,
		"1000000000",
		"1000000000",
		"0",
		"0",
		9999999999,
		adminAddr,
		adminAddr,
		"",
	)

	// Mint position for bar <-> wugnot pool
	position.Mint(
		cross,
		wugnotPath,
		barPath,
		3000,
		-887220,
		887220,
		"1000000000",
		"1000000000",
		"0",
		"0",
		9999999999,
		adminAddr,
		adminAddr,
		"",
	)
}

func doubleHopExactIn() {
	testing.SetRealm(adminRealm)
	testing.SetOriginSend(chain.Coins{})

	metric.PrintMetricsBy("MultiHop ExactIn (2 hops)", func() {
		router.ExactInSwapRoute(
			cross,
			gnsPath,
			wugnotPath,
			"10000000",
			"gno.land/r/gnoswap/gns:gno.land/r/onbloc/obl:3000*POOL*gno.land/r/onbloc/obl:gno.land/r/gnoland/wugnot:3000",
			"100",
			"0",
			9999999999,
			"",
		)
	})
}

func doubleHopExactOut() {
	testing.SetRealm(adminRealm)
	testing.SetOriginSend(chain.Coins{})

	metric.PrintMetricsBy("MultiHop ExactOut (2 hops)", func() {
		router.ExactOutSwapRoute(
			cross,
			gnsPath,
			wugnotPath,
			"10000000",
			"gno.land/r/gnoswap/gns:gno.land/r/onbloc/obl:3000*POOL*gno.land/r/onbloc/obl:gno.land/r/gnoland/wugnot:3000",
			"100",
			"100000000",
			9999999999,
			"",
		)
	})
}

func tripleHopExactIn() {
	testing.SetRealm(adminRealm)
	testing.SetOriginSend(chain.Coins{})

	metric.PrintMetricsBy("MultiHop ExactIn (3 hops)", func() {
		router.ExactInSwapRoute(
			cross,
			gnsPath,
			wugnotPath,
			"10000000",
			"gno.land/r/gnoswap/gns:gno.land/r/onbloc/obl:3000*POOL*gno.land/r/onbloc/obl:gno.land/r/onbloc/bar:3000*POOL*gno.land/r/onbloc/bar:gno.land/r/gnoland/wugnot:3000",
			"100",
			"0",
			9999999999,
			"",
		)
	})
}

func tripleHopExactOut() {
	testing.SetRealm(adminRealm)
	testing.SetOriginSend(chain.Coins{})

	metric.PrintMetricsBy("MultiHop ExactOut (3 hops)", func() {
		router.ExactOutSwapRoute(
			cross,
			gnsPath,
			wugnotPath,
			"10000000",
			"gno.land/r/gnoswap/gns:gno.land/r/onbloc/obl:3000*POOL*gno.land/r/onbloc/obl:gno.land/r/onbloc/bar:3000*POOL*gno.land/r/onbloc/bar:gno.land/r/gnoland/wugnot:3000",
			"100",
			"100000000",
			9999999999,
			"",
		)
	})
}

func multiRouteExactIn() {
	testing.SetRealm(adminRealm)
	testing.SetOriginSend(chain.Coins{})

	// Multi-route: 50% direct + 50% via obl
	// Route 1: gns -> wugnot (direct)
	// Route 2: gns -> obl -> wugnot (2 hops)
	metric.PrintMetricsBy("MultiRoute ExactIn (50:50 split)", func() {
		router.ExactInSwapRoute(
			cross,
			gnsPath,
			wugnotPath,
			"10000000",
			"gno.land/r/gnoswap/gns:gno.land/r/gnoland/wugnot:3000,gno.land/r/gnoswap/gns:gno.land/r/onbloc/obl:3000*POOL*gno.land/r/onbloc/obl:gno.land/r/gnoland/wugnot:3000",
			"50,50",
			"0",
			9999999999,
			"",
		)
	})
}

func multiRouteExactOut() {
	testing.SetRealm(adminRealm)
	testing.SetOriginSend(chain.Coins{})

	// Multi-route: 50% direct + 50% via obl
	metric.PrintMetricsBy("MultiRoute ExactOut (50:50 split)", func() {
		router.ExactOutSwapRoute(
			cross,
			gnsPath,
			wugnotPath,
			"10000000",
			"gno.land/r/gnoswap/gns:gno.land/r/gnoland/wugnot:3000,gno.land/r/gnoswap/gns:gno.land/r/onbloc/obl:3000*POOL*gno.land/r/onbloc/obl:gno.land/r/gnoland/wugnot:3000",
			"50,50",
			"100000000",
			9999999999,
			"",
		)
	})
}
