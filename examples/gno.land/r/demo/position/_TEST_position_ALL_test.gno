package position

import (
	"std"
	"testing"

	"gno.land/r/demo/gnoswap/common"
	"gno.land/r/demo/gnoswap/consts"

	pl "gno.land/r/demo/pool"

	"gno.land/r/demo/bar"
	"gno.land/r/demo/foo"

	"gno.land/r/demo/gns"
)

func TestPoolInitCreatePool(t *testing.T) {
	std.TestSetPrevAddr(test1)
	gns.Faucet()
	gns.Faucet()
	gns.Faucet()
	gns.Faucet()
	gns.Faucet()

	gns.Approve(a2u(consts.POOL_ADDR), consts.POOL_CREATION_FEE)
	pl.CreatePool(barPath, fooPath, fee500, common.TickMathGetSqrtRatioAtTick(1).ToString())
	// EVENT {GNOSWAP gno.land/r/demo/pool CreatePool [{p_poolPath gno.land/r/demo/bar:gno.land/r/demo/foo:500}]}
}

func TestMintPositionFullInRange(t *testing.T) {
	std.TestSetPrevAddr(test1)
	bar.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)
	foo.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)

	tokenId, liquidity, amount0, amount1 := Mint(
		barPath,
		fooPath,
		fee500,
		-887270,
		887270,
		"50000",
		"50000",
		"0",
		"0",
		max_timeout,
		test1.String(),
	)
	// EVENT {GNOSWAP gno.land/r/demo/position Mint [{p_poolPath gno.land/r/demo/bar:gno.land/r/demo/foo:500} {p_tickLower -887270} {p_tickUpper 887270} {tokenId 1} {liquidity 49997} {amount0 49995} {amount1 50000}]}

}

func TestIncreaseLiquidity(t *testing.T) {
	std.TestSetPrevAddr(test1)
	bar.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)
	foo.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)

	tokenId, liquidity, amount0, amount1, poolPath := IncreaseLiquidity(
		uint64(1),
		"50000",
		"50000",
		"0",
		"0",
		max_timeout,
	)
	// EVENT {GNOSWAP gno.land/r/demo/position IncreaseLiquidity [{p_tokenId 1} {poolPath gno.land/r/demo/bar:gno.land/r/demo/foo:500} {liquidity 49997} {amount0 49995} {amount1 50000}]
}

func TestDecreaseLiquidity(t *testing.T) {
	std.TestSetPrevAddr(test1)
	bar.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)
	foo.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)

	tokenId, liquidity, fee0, fee1, amount0, amount1, poolPath := DecreaseLiquidity(
		uint64(1),
		uint64(50),
		"0",
		"0",
		max_timeout,
		false,
	)
	// EVENT {GNOSWAP gno.land/r/demo/position CollectFee [{p_tokenId 1} {fee0 0} {fee1 0} {poolPath gno.land/r/demo/bar:gno.land/r/demo/foo:500}]}
	// EVENT {GNOSWAP gno.land/r/demo/position DecreaseLiquidity [{p_tokenId 1} {p_liquidityRatio 50} {poolPath gno.land/r/demo/bar:gno.land/r/demo/foo:500} {liquidity 49997} {fee0 0} {fee1 0} {amount0 49994} {amount1 49999}]}

}

func TestCollectFee(t *testing.T) {
	std.TestSetPrevAddr(test1)
	bar.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)
	foo.Approve(a2u(consts.POOL_ADDR), consts.UINT64_MAX)

	tokenId, fee0, fee1, poolPath := CollectFee(
		uint64(1),
	)
	// EVENT {GNOSWAP gno.land/r/demo/position CollectFee [{p_tokenId 1} {fee0 0} {fee1 0} {poolPath gno.land/r/demo/bar:gno.land/r/demo/foo:500}]}

}
