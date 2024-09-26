package launchpad

import (
	"std"
	"strings"
	"time"

	"gno.land/p/demo/ufmt"

	"gno.land/r/gnoswap/v2/consts"

	"gno.land/r/gnoswap/v2/gns"
	"gno.land/r/gnoswap/v2/gov/xgns"
)

var (
	// user -> project -> tier -> []deposit
	depositHistory map[string]map[string]map[string][]Deposit = make(map[string]map[string]map[string][]Deposit)
)

func DepositGns(
	targetProjectTierId string,
	amount uint64,
) {
	projectId, tierId := getProjectAndTierId(targetProjectTierId)
	project, exist := projects[projectId]
	if !exist {
		panic(ufmt.Sprintf("project not found: %s", projectId))
	}

	// check conditions (grc20 tokens balance)
	checkDepositConditions(project)

	// check if project is active
	checkProjectActive(project)

	// check if tier is active
	var tier Tier
	switch tierId {
	case "30":
		tier = project.tier30
	case "60":
		tier = project.tier60
	case "180":
		tier = project.tier180
	default:
		panic(ufmt.Sprintf("invalid tierId: %s", tierId))
	}

	checkTierActive(project, tier)

	// gns will be locked in `launchpad` contract
	gns.TransferFrom(
		a2u(std.GetOrigCaller()),
		a2u(std.Address(consts.LAUNCHPAD_ADDR)),
		amount,
	)

	// xgns will be minted to the `launchpad` contract
	xgns.Mint(
		a2u(std.Address(consts.LAUNCHPAD_ADDR)),
		amount,
	)

	project.totalDepositAmount += amount
	project.totalParticipant += 1

	tier.depositAmount += amount
	tier.participant += 1
	// XXX: update project and tier in the map??

	// XXX: depositHistory append

	// XXX: emit event
}

func getProjectIdFromTierId(tierId string) string {
	// gno.land/r/gnoswap/gns:123:30
	// gno.land/r/gnoswap/gns:123

	result := strings.Split(tierId, ":")
	if len(result) == 3 {
		return result[0] + ":" + result[1]
	}

	panic(ufmt.Sprintf("invalid tierId: %s", tierId))
}

func getProjectAndTierId(tierId string) (string, string) {
	result := strings.Split(tierId, ":")
	if len(result) == 3 {
		return result[0] + ":" + result[1], result[2]
	}

	panic(ufmt.Sprintf("invalid tierId: %s", tierId))
}

func checkDepositConditions(project Project) {
	for _, condition := range project.conditions {
		if condition.minAmount == 0 {
			continue
		} else {
			// check balance
			balance := balanceOfByRegisterCall(condition.tokenPath, std.GetOrigCaller())
			if balance < condition.minAmount {
				panic(ufmt.Sprintf("insufficient balance(%d) for token(%s)", balance, condition.tokenPath))
			}
		}
	}
}

func checkProjectActive(project Project) {
	if project.startTime > uint64(time.Now().Unix()) {
		panic(ufmt.Sprintf("project not started yet: %d", project.startTime))
	}
}

func checkTierActive(project Project, tier Tier) {
	if tier.endTime < uint64(time.Now().Unix()) {
		panic(ufmt.Sprintf("tier ended: %d", tier.endTime))
	}
}
