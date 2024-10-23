package regcall

import (
	"std"

	pusers "gno.land/p/demo/users"
)

func TransferFromPrev() {
	println("regcall_TransferFromPrev()")
	curr := std.CurrentRealm()
	println("currPath:", curr.PkgPath())
	println("currAddr:", curr.Addr())
	prev := std.PrevRealm()
	println("prevPath:", prev.PkgPath())
	println("prevAddr:", prev.Addr())
	println()

	// fooToken := reg.MustGet("gno.land/r/demo/foo")
	// checkErr(fooToken.TransferFrom(prev.Addr(), curr.Addr(), 1000))
}

func checkErr(err error) {
	if err != nil {
		panic(err.Error())
	}
}

func a2u(addr std.Address) pusers.AddressOrName {
	return pusers.AddressOrName(addr)
}
