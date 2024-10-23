package frame

import (
	"std"

	pframe "gno.land/p/demo/frame"

	"gno.land/p/demo/grc/grc20"
	"gno.land/p/demo/ownable"

	"gno.land/r/demo/grc20reg"
)

var (
	banker *grc20.Banker
	admin  *ownable.Ownable
	token  grc20.Token
)

func init() {
	admin = ownable.NewWithAddress("g1u7y667z64x2h7vc6fmpcprgey4ck233jaww9zq") // @manfred
	banker = grc20.NewBanker("Foo", "FOO", 4)
	banker.Mint(admin.Owner(), 1000000*10000) // @administrator (1M)
	token = banker.Token()

	grc20reg.Register(token, "")
	println("F_INIT")
}

func PrintFrame() string {
	origCaller := std.GetOrigCaller()

	prev := std.PrevRealm()
	prevPath := prev.PkgPath()
	prevAddr := prev.Addr()

	curr := std.CurrentRealm()
	currPath := curr.PkgPath()
	currAddr := curr.Addr()

	println("f_origCaller", origCaller)
	println("f_prevPath", prevPath)
	println("f_prevAddr", prevAddr)
	println("f_currPath", currPath)
	println("f_currAddr", currAddr)
	println()

	pframe.PrintFrame()
	println()

	return origCaller.String() + "_" + prevPath + "_" + prevAddr.String() + "_" + currPath + "_" + currAddr.String()
}
