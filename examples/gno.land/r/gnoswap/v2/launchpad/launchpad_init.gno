package launchpad

import (
	"std"
	"strings"
	"time"

	"gno.land/p/demo/ufmt"

	"gno.land/r/gnoswap/v2/consts"
)

var (
	projects map[string]Project = make(map[string]Project)
)

func init() {
	println("main_init")
}

func CreateProject(
	tokenPath string,
	recipient std.Address,
	depositAmount uint64,
	conditionsToken string, // SEP BY *PAD*
	conditionsAmount string, // SEP BY *PAD*
	tier30Ratio uint64, // 10 => 10%
	tier60Ratio uint64, // 20
	tier180Ratio uint64, // 70
	startTime uint64,
) {
	// only admin can create project
	if std.GetOrigCaller() != consts.GNOSWAP_ADMIN {
		panic("only admin can create project")
	}

	if !(recipient.IsValid()) {
		panic("invalid recipient addr")
	}

	projectId := generateProjectId(tokenPath)
	_, exist := projects[projectId]
	if exist {
		panic("project already exist")
	}

	if tier30Ratio+tier60Ratio+tier180Ratio != 100 {
		panic("invalid ratio, sum of all tiers should be 100")
	}

	transferFromByRegisterCall(
		tokenPath,
		std.GetOrigCaller(),
		std.Address(consts.LAUNCHPAD_ADDR),
		depositAmount,
	)

	tier30Amount := depositAmount * tier30Ratio / 100
	tier60Amount := depositAmount * tier60Ratio / 100
	tier180Amount := depositAmount * tier180Ratio / 100
	sumAll := tier30Amount + tier60Amount + tier180Amount
	left := depositAmount - sumAll
	if left > 0 {
		// uAmounts can be left due to rounding
		// XXX: how to handle this?
		// tier180Amount += left
	}
	createdHeight := uint64(std.GetHeight())
	createdTime := uint64(time.Now().Unix())

	// check grc20 required conditions
	conditions := makeConditions(conditionsToken, conditionsAmount)

	// create tier
	tier30 := Tier{
		id:                generateTierId(projectId, 30),
		claimWaitDuration: TIMESTAMP_3DAYS,
		tierAmount:        tier30Amount,
		endTime:           createdTime + TIMESTAMP_30DAYS,
	}
	tier60 := Tier{
		id:                generateTierId(projectId, 60),
		claimWaitDuration: TIMESTAMP_7DAYS,
		tierAmount:        tier60Amount,
		endTime:           createdTime + TIMESTAMP_90DAYS,
	}
	tier180 := Tier{
		id:                generateTierId(projectId, 180),
		claimWaitDuration: TIMESTAMP_14DAYS,
		tierAmount:        tier180Amount,
		endTime:           createdTime + TIMESTAMP_180DAYS,
	}

	// create project
	project := Project{
		id:            projectId,
		tokenPath:     tokenPath,
		depositAmount: depositAmount,
		recipient:     recipient,
		conditions:    conditions,
		tier30Ratio:   tier30Ratio,
		tier30:        tier30,
		tier60:        tier60,
		tier60Ratio:   tier60Ratio,
		tier180:       tier180,
		tier180Ratio:  tier180Ratio,
		createdHeight: createdHeight,
		createdTime:   createdTime,
		startTime:     startTime,
	}

	projects[projectId] = project

	// XXX: emit event
	// std.Emit()
}

func generateProjectId(tokenPath string) string {
	// gno.land/r/gnoswap/gns:123
	return ufmt.Sprintf("%s:%d", tokenPath, std.GetHeight())
}

func generateTierId(projectId string, duration uint64) string {
	// gno.land/r/gnoswap/gns:123:30
	return ufmt.Sprintf("%s:%d", projectId, duration)
}

func makeConditions(conditionsToken string, conditionsAmount string) map[string]Condition {
	conditions := make(map[string]Condition)

	tokens := strings.Split(conditionsToken, "*PAD*")
	amounts := strings.Split(conditionsAmount, "*PAD*")
	if len(tokens) != len(amounts) {
		panic(ufmt.Sprintf("invalid conditions(numTokens(%d) != numAmounts(%d))", len(tokens), len(amounts)))
	}

	for i, token := range tokens {
		conditions[token] = Condition{
			tokenPath: token,
			minAmount: parseUint(amounts[i], 10, 64),
		}
	}
	return conditions
}
