package params

const (
	bankModulePrefix    = "bank"
	restrictedDenomsKey = "restricted_denoms"
	unlockTransferTitle = "Proposal to unlock the transfer of ugnot."
	lockTransferTitle   = "Proposal to lock the transfer of ugnot."
)

func ProposeUnlockTransfer() uint64 {
	exe := NewSysParamStringsPropExecutor(bankModulePrefix, "p", restrictedDenomsKey, []string{})
	return propose(exe, unlockTransferTitle, "")
}

func ProposeLockTransfer() uint64 {
	exe := NewSysParamStringsPropExecutor(bankModulePrefix, "p", restrictedDenomsKey, []string{"ugnot"})
	return propose(exe, lockTransferTitle, "")
}
