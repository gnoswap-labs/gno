package router

import (
	"std"

	u256 "gno.land/p/gnoswap/uint256"
)

func singleSwap(params SingleSwapParams) (*u256.Uint, *u256.Uint) { // amountIn, amountOut
	// myunghwan, Change GetOrigCaller to PrevRealm().Addr()
	// TODO :
	// 1. Check if the caller is the owner of the tokenIn
	amountIn, amountOut := _swap(
		params.amountSpecified,
		std.PrevRealm().Addr(), // if single swap => user will recieve
		u256.Zero(),            // sqrtPriceLimitX96
		SwapCallbackData{
			params.tokenIn,
			params.tokenOut,
			params.fee,
			std.PrevRealm().Addr(), // payer ==> msg.sender,
		},
	)

	return amountIn, amountOut
}

func singleSwapDry(params SingleSwapParams) (*u256.Uint, *u256.Uint) { // amountIn, amountOut
	amountIn, amountOut := _swapDry(
		params.amountSpecified,
		u256.Zero(), // sqrtPriceLimitX96
		SwapCallbackData{
			params.tokenIn,
			params.tokenOut,
			params.fee,
			std.PrevRealm().Addr(), // payer ==> msg.sender,
		},
	)

	return amountIn, amountOut
}
