package launchpad

import (
	"std"
)

type Project struct {
	id            string // 'tokenPath_createdHeight'
	tokenPath     string
	depositAmount uint64
	recipient     std.Address // string

	conditions map[string]Condition // tokenPath -> Condition

	tier30Ratio uint64
	tier30      Tier

	tier60      Tier
	tier60Ratio uint64

	tier180      Tier
	tier180Ratio uint64

	createdHeight uint64
	createdTime   uint64

	// startHeight uint64
	startTime uint64

	// statistics
	totalDepositAmount uint64
	totalParticipant   uint64
}

type Tier struct {
	id                string // 'tokenPath_createdHeight_duration'
	claimWaitDuration uint64
	tierAmount        uint64

	// start height/time is same as the project
	// endHeight uint64 // XXX: estimate ??
	endTime uint64

	depositAmount uint64
	participant   uint64 // auto increment
}

type Condition struct {
	tokenPath string
	minAmount uint64
}

type Deposit struct {
	proejctId     string      //
	tier          string      // instead of tierId
	depositor     std.Address // string
	amount        uint64
	depositHeight uint64
	depositAt     uint64 // timestamp
}
