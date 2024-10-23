package frame

import (
	"std"

	"gno.land/r/demo/frame"
)

func init() {
	println("FF_INIT")
}

func PrintFrame() string {
	origCaller := std.GetOrigCaller()

	prev := std.PrevRealm()
	prevPath := prev.PkgPath()
	prevAddr := prev.Addr()

	curr := std.CurrentRealm()
	currPath := curr.PkgPath()
	currAddr := curr.Addr()

	println("ff_origCaller", origCaller)
	println("ff_prevPath", prevPath)
	println("ff_prevAddr", prevAddr)
	println("ff_currPath", currPath)
	println("ff_currAddr", currAddr)
	println()

	frame.PrintFrame()
	println()

	return origCaller.String() + "_" + prevPath + "_" + prevAddr.String() + "_" + currPath + "_" + currAddr.String()
}
