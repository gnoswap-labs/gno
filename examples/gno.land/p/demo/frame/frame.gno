package frame

import (
	"std"
)

func PrintFrame() string {
	origCaller := std.GetOrigCaller()

	prev := std.PrevRealm()
	prevPath := prev.PkgPath()
	prevAddr := prev.Addr()

	curr := std.CurrentRealm()
	currPath := curr.PkgPath()
	currAddr := curr.Addr()

	println("p_origCaller", origCaller)
	println("p_prevPath", prevPath)
	println("p_prevAddr", prevAddr)
	println("p_currPath", currPath)
	println("p_currAddr", currAddr)
	println()

	return origCaller.String() + "_" + prevPath + "_" + prevAddr.String() + "_" + currPath + "_" + currAddr.String()
}
