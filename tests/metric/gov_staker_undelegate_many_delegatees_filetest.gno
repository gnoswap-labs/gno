// Performance test for undelegate with many delegatees
// Tests getUserDelegations optimization with large delegation tree traversal
package main

import (
	"testing"

	prabc "gno.land/p/gnoswap/rbac"
	"gno.land/p/nt/testutils"
	_ "gno.land/r/gnoswap/rbac"

	_ "gno.land/r/gnoswap/gov/staker/v1"

	"gno.land/r/gnoswap/access"
	"gno.land/r/gnoswap/gns"
	govstaker "gno.land/r/gnoswap/gov/staker"

	"gno.land/r/gnoswap/scenario/metric"
)

var (
	adminAddr, _ = access.GetAddress(prabc.ROLE_ADMIN.String())
	adminRealm   = testing.NewUserRealm(adminAddr)

	govStakerAddr, _ = access.GetAddress(prabc.ROLE_GOV_STAKER.String())

	maxInt64 int64 = 9223372036854775807
)

func main() {
	testing.SetRealm(adminRealm)

	gns.Approve(cross, govStakerAddr, maxInt64)

	// Create 50 delegations to different delegatees
	delegatees := []address{
		testutils.TestAddress("user1"), testutils.TestAddress("user2"),
		testutils.TestAddress("user3"), testutils.TestAddress("user4"),
		testutils.TestAddress("user5"), testutils.TestAddress("user6"),
		testutils.TestAddress("user7"), testutils.TestAddress("user8"),
		testutils.TestAddress("user9"), testutils.TestAddress("user10"),
		testutils.TestAddress("user11"), testutils.TestAddress("user12"),
		testutils.TestAddress("user13"), testutils.TestAddress("user14"),
		testutils.TestAddress("user15"), testutils.TestAddress("user16"),
		testutils.TestAddress("user17"), testutils.TestAddress("user18"),
		testutils.TestAddress("user19"), testutils.TestAddress("user20"),
		testutils.TestAddress("user21"), testutils.TestAddress("user22"),
		testutils.TestAddress("user23"), testutils.TestAddress("user24"),
		testutils.TestAddress("user25"), testutils.TestAddress("user26"),
		testutils.TestAddress("user27"), testutils.TestAddress("user28"),
		testutils.TestAddress("user29"), testutils.TestAddress("user30"),
		testutils.TestAddress("user31"), testutils.TestAddress("user32"),
		testutils.TestAddress("user33"), testutils.TestAddress("user34"),
		testutils.TestAddress("user35"), testutils.TestAddress("user36"),
		testutils.TestAddress("user37"), testutils.TestAddress("user38"),
		testutils.TestAddress("user39"), testutils.TestAddress("user40"),
		testutils.TestAddress("user41"), testutils.TestAddress("user42"),
		testutils.TestAddress("user43"), testutils.TestAddress("user44"),
		testutils.TestAddress("user45"), testutils.TestAddress("user46"),
		testutils.TestAddress("user47"), testutils.TestAddress("user48"),
		testutils.TestAddress("user49"), testutils.TestAddress("user50"),
	}

	for _, delegatee := range delegatees {
		govstaker.Delegate(cross, delegatee, int64(1000000), "")
	}

	// Undelegate from the last delegatee to force a large-tree lookup under current semantics
	metric.PrintMetricsBy("Undelegate (50 delegatees, large AVL traversal)", func() {
		govstaker.Undelegate(cross, delegatees[len(delegatees)-1], int64(1000000))
	})
}
