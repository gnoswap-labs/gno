// Gas and performance metrics for position reposition
// Test cases based on tests/integration/testdata/position/reposition.txtar
package main

import (
	"testing"

	prabc "gno.land/p/gnoswap/rbac"
	"gno.land/p/nt/testutils"
	_ "gno.land/r/gnoswap/rbac"

	_ "gno.land/r/gnoswap/pool/v1"
	_ "gno.land/r/gnoswap/position/v1"
	_ "gno.land/r/gnoswap/protocol_fee/v1"
	_ "gno.land/r/gnoswap/staker/v1"

	"gno.land/r/gnoswap/access"
	"gno.land/r/gnoswap/common"
	"gno.land/r/gnoswap/pool"
	"gno.land/r/gnoswap/position"

	"gno.land/r/onbloc/bar"
	"gno.land/r/onbloc/foo"

	"gno.land/r/gnoswap/scenario/metric"
)

var (
	adminAddr, _ = access.GetAddress(prabc.ROLE_ADMIN.String())
	adminRealm   = testing.NewUserRealm(adminAddr)

	poolAddr, _ = access.GetAddress(prabc.ROLE_POOL.String())

	aliceAddr  = testutils.TestAddress("alice")
	aliceRealm = testing.NewUserRealm(aliceAddr)

	barPath = "gno.land/r/onbloc/bar"
	fooPath = "gno.land/r/onbloc/foo"

	maxInt64 int64 = 9223372036854775807
)

var t *testing.T

func main() {
	initializeSetup()
	createPool500()
	mintInitialPosition()

	decreaseAndRemovePositionMetric()
	mintNewPositionMetric()
}

func initializeSetup() {
	testing.SetRealm(adminRealm)
	pool.SetPoolCreationFee(cross, 0)

	bar.Transfer(cross, aliceAddr, 100000000)
	foo.Transfer(cross, aliceAddr, 100000000)

	bar.Approve(cross, poolAddr, maxInt64)
	foo.Approve(cross, poolAddr, maxInt64)
}

func createPool500() {
	testing.SetRealm(adminRealm)

	pool.CreatePool(
		cross,
		barPath,
		fooPath,
		500,
		common.TickMathGetSqrtRatioAtTick(0).ToString(),
	)
}

func mintInitialPosition() {
	testing.SetRealm(aliceRealm)
	bar.Approve(cross, poolAddr, maxInt64)
	foo.Approve(cross, poolAddr, maxInt64)

	position.Mint(
		cross,
		barPath,
		fooPath,
		500,
		-1000,
		1000,
		"50000000",
		"50000000",
		"0",
		"0",
		9999999999,
		aliceAddr,
		aliceAddr,
		"",
	)
}

func decreaseAndRemovePositionMetric() {
	testing.SetRealm(aliceRealm)

	metric.PrintMetricsBy("DecreaseLiquidity (w. Remove)", func() {
		position.DecreaseLiquidity(
			cross,
			1,
			"100",
			"0",
			"0",
			9999999999,
		)
	})
}

func mintNewPositionMetric() {
	testing.SetRealm(aliceRealm)

	metric.PrintMetricsBy("Mint (reposition)", func() {
		position.Mint(
			cross,
			barPath,
			fooPath,
			500,
			-2000,
			2000,
			"30000000",
			"30000000",
			"0",
			"0",
			9999999999,
			aliceAddr,
			aliceAddr,
			"",
		)
	})
}
