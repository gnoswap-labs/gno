package common

import (
	"errors"

	"gno.land/p/demo/ufmt"
)

const (
	GNOSWAP_ERROR_BASE = 100
)

var (
	POOL_ERROR_BASE     = GNOSWAP_ERROR_BASE * 1
	POSITION_ERROR_BASE = GNOSWAP_ERROR_BASE * 2
	ROUTER_ERROR_BASE   = GNOSWAP_ERROR_BASE * 3
	STAKER_ERROR_BASE   = GNOSWAP_ERROR_BASE * 4
)

// error for `commont` itself
var (
	errNoPermission = errors.New("[GNOSWAP-COMMON-001] caller has no permission")
	errHalted       = errors.New("[GNOSWAP-COMMON-002] halted")
	errOutOfRange   = errors.New("[GNOSWAP-COMMON-003] value out of range")
)

func addDetailToError(err error, detail string) string {
	finalErr := ufmt.Errorf("%s || %s", err.Error(), detail)
	return finalErr.Error()
}
