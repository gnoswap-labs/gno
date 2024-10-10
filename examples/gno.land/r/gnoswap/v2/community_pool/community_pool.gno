package community_pool

import (
	"std"

	"gno.land/p/demo/ufmt"
	pusers "gno.land/p/demo/users"

	"gno.land/r/gnoswap/v2/common"
	"gno.land/r/gnoswap/v2/consts"
)

// OnlyAdminTransferToken transfers token to the given address.
// Panics if the caller is not the admin.
func OnlyAdminTransferToken(pkgPath string, to std.Address, amount uint64) {
	caller := std.PrevRealm().Addr()
	if caller != consts.GNOSWAP_ADMIN {
		panic(
			ufmt.Sprintf(
				"[COMMUNITY_POOL] community_pool.gno__OnlyAdminTransferToken() || only admin(%s) can transfer token, called from %s",
				consts.GNOSWAP_ADMIN,
				caller,
			),
		)
	}

	transferToken(pkgPath, to, amount)
	std.Emit(
		"TransferTokenByAdmin",
		"p_pkgPath", pkgPath,
		"p_to", to,
		"p_amount", amount,
	)
}

// OnlyGovernanceTransferToken transfers token to the given address.
// Panics if the caller is not the governance contract.
func OnlyGovernanceTransferToken(pkgPath string, to std.Address, amount uint64) {
	caller := std.PrevRealm().Addr()
	if caller != consts.GOV_GOVERNANCE_ADDR {
		panic(
			ufmt.Sprintf(
				"[COMMUNITY_POOL] community_pool.gno__OnlyGovernanceTransferToken() || only governance(%s) can transfer token, called from %s",
				consts.GOV_GOVERNANCE_ADDR,
				caller,
			),
		)
	}

	transferToken(pkgPath, to, amount)
	std.Emit(
		"TransferTokenByGovernance",
		"p_pkgPath", pkgPath,
		"p_to", to,
		"p_amount", amount,
	)
}

func transferToken(pkgPath string, to std.Address, amount uint64) {
	common.IsHalted()

	_, found := registered[pkgPath]
	if !found {
		panic(ufmt.Sprintf("[COMMUNITY_POOL] community_pool.gno__transferToken() || pkgPath(%s) not registered", pkgPath))
	}

	registered[pkgPath].Transfer()(a2u(to), amount)
}

func a2u(addr std.Address) pusers.AddressOrName {
	return pusers.AddressOrName(addr)
}
