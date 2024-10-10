package common

import (
	"std"

	"gno.land/p/demo/ufmt"

	"gno.land/r/gnoswap/v2/consts"
)

var (
	halted bool = false
)

func GetHalt() bool {
	return halted
}

func IsHalted() {
	if halted {
		panic("[COMMON] halt.gno__IsHalted() || gnoswap halted")
	}
}

// OnlyAdminSetHalt sets the halt status.
// Panics if the caller is not the admin.
func OnlyAdminSetHalt(halt bool) {
	caller := std.PrevRealm().Addr()
	if caller != consts.GNOSWAP_ADMIN {
		panic(
			ufmt.Sprintf(
				"[COMMON] halt.gno__OnlyAdminSetHalt() || only admin(%s) can set halt, called from %s",
				consts.GNOSWAP_ADMIN,
				caller,
			),
		)
	}

	setHalt(halt)

	if halt {
		std.Emit(
			"SetHaltByAdmin",
			"p_halt", boolToStr(halt),
		)
	} else {
		std.Emit(
			"UnsetHaltByAdmin",
			"p_halt", boolToStr(halt),
		)
	}
}

// OnlyGovernanceSetHalt sets the halt status.
// Panics if the caller is not the governance contract.
func OnlyGovernanceSetHalt(halt bool) {
	caller := std.PrevRealm().Addr()
	if caller != consts.GOV_GOVERNANCE_ADDR {
		panic(
			ufmt.Sprintf(
				"[COMMON] halt.gno__OnlyGovernanceSetHalt() || only governance(%s) can set halt, called from %s",
				consts.GOV_GOVERNANCE_ADDR,
				caller,
			),
		)
	}

	setHalt(halt)

	if halt {
		std.Emit(
			"SetHaltByGovernance",
			"p_halt", boolToStr(halt),
		)
	} else {
		std.Emit(
			"UnsetHaltByGovernance",
			"p_halt", boolToStr(halt),
		)
	}
}

func setHalt(halt bool) {
	halted = halt
}

func boolToStr(b bool) string {
	if b {
		return "true"
	}

	return "false"
}
