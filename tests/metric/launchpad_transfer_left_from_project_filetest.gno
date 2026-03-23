// Gas and performance metrics for launchpad TransferLeftFromProjectByAdmin
// Test cases based on gnoswap/contract/r/scenario/launchpad/launchpad_refund_ended_project_no_deposit_filetest.gno
package main

import (
	"testing"
	"time"

	prabc "gno.land/p/gnoswap/rbac"
	"gno.land/p/nt/testutils"
	_ "gno.land/r/gnoswap/rbac"

	_ "gno.land/r/gnoswap/launchpad/v1"

	"gno.land/r/gnoswap/access"
	"gno.land/r/gnoswap/launchpad"
	"gno.land/r/onbloc/obl"

	"gno.land/r/gnoswap/scenario/metric"
)

const blockTimeSeconds int64 = 5

var (
	adminAddr, _ = access.GetAddress(prabc.ROLE_ADMIN.String())
	adminRealm   = testing.NewUserRealm(adminAddr)

	launchpadAddr, _ = access.GetAddress(prabc.ROLE_LAUNCHPAD.String())

	projectAddr = testutils.TestAddress("project-owner")

	maxInt64 int64 = 9223372036854775807
)

var t *testing.T

func main() {
	initializeSetup()
	projectId := createLaunchpadProject()
	skipToProjectEnd()
	transferLeftFromProjectMetric(projectId)
}

func initializeSetup() {
	testing.SetRealm(adminRealm)
	obl.Approve(cross, launchpadAddr, maxInt64)
}

func createLaunchpadProject() string {
	testing.SetRealm(adminRealm)

	projectId := launchpad.CreateProject(
		cross,
		"OBL Launchpad Project",
		"gno.land/r/onbloc/obl",
		projectAddr,
		int64(1_000_000_000),
		"",
		"",
		int64(10),
		int64(20),
		int64(70),
		time.Now().Unix()+604800,
	)

	// Activate project.
	testing.SkipHeights(604800 / blockTimeSeconds)

	return projectId
}

func skipToProjectEnd() {
	projectDurationSeconds := int64(180 * 24 * 60 * 60)
	testing.SkipHeights(projectDurationSeconds/blockTimeSeconds + 1)
}

func transferLeftFromProjectMetric(projectId string) {
	testing.SetRealm(adminRealm)

	metric.PrintMetricsBy("Launchpad TransferLeftFromProjectByAdmin", func() {
		_ = launchpad.TransferLeftFromProjectByAdmin(cross, projectId, projectAddr)
	})
}
