package pool

import (
	i256 "gno.land/p/gnoswap/int256"
	u256 "gno.land/p/gnoswap/uint256"

	"gno.land/r/gnoswap/v2/consts"
)

func liquidityMathAddDelta(x *u256.Uint, y *i256.Int) *u256.Uint {
	if y.Lt(i256.Zero()) {
		z := new(u256.Uint).Sub(x, y.Abs())

		if !(z.Lt(x)) {
			panic("LS")
		}
		isInRangeFor128(z)
		return z // z < x
	}

	z := new(u256.Uint).Add(x, y.Abs())

	if !(z.Gte(x)) {
		panic("LA")
	}

	isInRangeFor128(z)
	return z // z >= x
}

func isInRangeFor128(x *u256.Uint) {
	maxUint128 := u256.MustFromDecimal(consts.MAX_UINT128)
	if x.Gt(maxUint128) {
		panic("Over uint128 range")
	}
}
