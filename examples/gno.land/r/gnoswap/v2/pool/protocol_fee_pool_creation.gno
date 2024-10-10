package pool

import (
	"std"

	"gno.land/r/gnoswap/v2/common"
	"gno.land/r/gnoswap/v2/consts"

	"gno.land/p/demo/ufmt"
)

// poolCreationFee is the fee that is charged when a user creates a pool.
//
// The fee is denominated in GNS tokens.
var (
	poolCreationFee = uint64(100_000_000) // 100_GNS
)

// GetPoolCreationFee returns the poolCreationFee
func GetPoolCreationFee() uint64 {
	return poolCreationFee
}

// OnlyAdminSetPoolCreationFee sets the poolCreationFee.
// Panics if the caller is not the admin.
func OnlyAdminSetPoolCreationFee(fee uint64) {
	caller := std.PrevRealm().Addr()
	if caller != consts.GNOSWAP_ADMIN {
		panic(
			ufmt.Sprintf(
				"[POOL] protocol_fee_pool_creation.gno__OnlyAdminSetPoolCreationFee() || only admin(%s) can set pool creation fee, called from %s",
				consts.GNOSWAP_ADMIN,
				caller,
			),
		)
	}

	setPoolCreationFee(fee)
	std.Emit(
		"SetPoolCreationFeeByAdmin",
		"p_fee", uint64ToStr(fee),
	)
}

// OnlyGovernanceSetPoolCreationFee sets the poolCreationFee.
// Panics if the caller is not the governance contract.
func OnlyGovernanceSetPoolCreationFee(fee uint64) {
	caller := std.PrevRealm().Addr()
	if caller != consts.GOV_GOVERNANCE_ADDR {
		panic(
			ufmt.Sprintf(
				"[POOL] protocol_fee_pool_creation.gno__OnlyGovernanceSetPoolCreationFee() || only governance(%s) can set pool creation fee, called from %s",
				consts.GOV_GOVERNANCE_ADDR,
				caller,
			),
		)
	}

	setPoolCreationFee(fee)
	std.Emit(
		"SetPoolCreationFeeByGovernance",
		"p_fee", uint64ToStr(fee),
	)
}

func setPoolCreationFee(fee uint64) {
	common.IsHalted()

	poolCreationFee = fee
}
