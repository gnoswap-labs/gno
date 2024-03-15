package rb

import (
	"std"
)

func Info() {
	println("rb.Info")
	println("std.GetOrigCaller():", std.GetOrigCaller())
	println("std.GetOrigPkgAddr():", std.GetOrigPkgAddr())
	println("std.PrevRealm():", std.PrevRealm())
	println("std.CurrentRealm():", std.CurrentRealm())
	println()
}
