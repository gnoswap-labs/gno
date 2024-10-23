package regcall

import (
	"std"

	// init will register the token

	pusers "gno.land/p/demo/users"
	"gno.land/r/demo/foo"
)

func RegCallTest() {
	// println("reg_TransferFromPrev")
	curr := std.CurrentRealm()
	currAddr := curr.Addr()
	currPath := curr.PkgPath()
	// println("> currPath", currPath) // regcall
	// println("> currAddr", currAddr) // g1xxxfzd

	prev := std.PrevRealm()
	prevAddr := prev.Addr()
	prevPath := prev.PkgPath()
	// println("> prevPath", prevPath) //
	// println("> prevAddr", prevAddr) // g1xxx9zq ≈ manfred
	// println()

	// fooToken := reg.MustGet("gno.land/r/demo/foo")
	// checkErr(fooToken.TransferFrom(prevAddr, currAddr, 1000))

	foo.TransferFrom(a2u(prevAddr), a2u(currAddr), 1000)
}

func checkErr(err error) {
	if err != nil {
		panic(err.Error())
	}
}

func a2u(addr std.Address) pusers.AddressOrName {
	return pusers.AddressOrName(addr)
}
