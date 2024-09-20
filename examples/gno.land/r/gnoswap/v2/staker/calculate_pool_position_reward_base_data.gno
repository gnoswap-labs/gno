package staker

import (
	pn "gno.land/r/gnoswap/v2/position"

	u256 "gno.land/p/gnoswap/uint256"
)

// calculateLiquidities calculates the liquidity of each pool and each position
// - poolTotalStakedLiquidity: total in-range staked liquidity of each pool
// - positionsLiquidityRatio: liquidity ratio(in Q96 notation) of each position
// - poolsPositions: which positions are in which pool
func CalculateLiquidity() {
	poolTotalStakedLiquidity = make(map[string]*u256.Uint) // clear
	for tokenId, deposit := range deposits {
		poolPath := deposit.targetPoolPath
		if _, exist := poolTotalStakedLiquidity[poolPath]; !exist {
			poolTotalStakedLiquidity[poolPath] = u256.Zero()
		}

		isInRange := pn.PositionIsInRange(tokenId)
		if isInRange == false {
			continue
		}

		positionLiquidity := pn.PositionGetPositionLiquidity(tokenId)
		poolTotalStakedLiquidity[poolPath] = poolTotalStakedLiquidity[poolPath].Add(poolTotalStakedLiquidity[poolPath], positionLiquidity)
	}

	// calculate each position's liquidity ratio
	// + also which pool has which positions
	positionsLiquidityRatio = make(map[uint64]*u256.Uint) // clear
	poolsPositions = make(map[string][]uint64)            // clear
	for tokenId, deposit := range deposits {
		poolPath := deposit.targetPoolPath
		isInRange := pn.PositionIsInRange(tokenId)
		if isInRange == false {
			positionsLiquidityRatio[tokenId] = u256.Zero()
		} else {
			poolTotalStakedLiquidity := poolTotalStakedLiquidity[poolPath]
			positionLiquidity := pn.PositionGetPositionLiquidity(tokenId)

			positionLiquidityX96x := new(u256.Uint).Mul(positionLiquidity, _q96)
			positionLiquidityX96x = positionLiquidityX96x.Mul(positionLiquidityX96x, u256.NewUint(1_000_000_000))

			poolTotalStakedLiquidityX96 := new(u256.Uint).Mul(poolTotalStakedLiquidity, _q96)

			positionLiquidityRatio := new(u256.Uint).Div(positionLiquidityX96x, poolTotalStakedLiquidityX96)         // this value needs to be divided by 1_000_000_000
			positionLiquidityRatio = positionLiquidityRatio.Mul(positionLiquidityRatio, _q96)                        // so first mul consts.Q96
			positionLiquidityRatio = positionLiquidityRatio.Div(positionLiquidityRatio, u256.NewUint(1_000_000_000)) // then divided by 1_000_000_000

			positionsLiquidityRatio[tokenId] = positionLiquidityRatio

			// poolsPositions
			poolsPositions[poolPath] = append(poolsPositions[poolPath], tokenId)
		}
	}
}
