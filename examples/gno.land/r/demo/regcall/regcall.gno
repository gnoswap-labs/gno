package regcall

import (
	"std"

	pusers "gno.land/p/demo/users"

	reg "gno.land/r/demo/grc20reg"
)

func TransferFromPrev() {
	curr := std.CurrentRealm()
	prev := std.PrevRealm()

	fooToken := reg.MustGet("gno.land/r/demo/foo")
	checkErr(fooToken.TransferFrom(prev.Addr(), curr.Addr(), 1000))
}

func checkErr(err error) {
	if err != nil {
		panic(err.Error())
	}
}

func a2u(addr std.Address) pusers.AddressOrName {
	return pusers.AddressOrName(addr)
}
