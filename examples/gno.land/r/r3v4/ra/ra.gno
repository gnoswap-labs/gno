package ra

import (
	"std"

	"gno.land/r/r3v4/rb"
)

func Info() {
	println("ra.Info")
	println("std.GetOrigCaller:", std.GetOrigCaller())
	println("std.GetOrigPkgAddr:", std.GetOrigPkgAddr())
	println("std.PrevRealm():", std.PrevRealm())
	println("std.CurrentRealm():", std.CurrentRealm())
	println("CALLING rb.Info()")
	rb.Info()
}
