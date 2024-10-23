package regcall

import (
	"std"
	"testing"

	// init will register the token
	"gno.land/r/demo/foo"
	// reg "gno.land/r/demo/grc20reg"
)

var (
	manfredAddr  = std.Address("g1u7y667z64x2h7vc6fmpcprgey4ck233jaww9zq")
	manfredRealm = std.NewUserRealm(manfredAddr)

	regCallAddr = std.Address("g1mxw23xdar2grl6jt5sgvvxhkh5msjajxf5pfzd")
	regCallPath = "gno.land/r/demo/regcall"
)

func TestTransferFromPrev(t *testing.T) {
	// approve using grc20reg  // only code level
	{
		// fooToken := reg.MustGet("gno.land/r/demo/foo")
		// std.TestSetRealm(manfredRealm)
		// checkErr(fooToken.Approve(regCallAddr, 1000))
	}

	// approve using import // code + (offchain) level
	std.TestSetRealm(manfredRealm)
	foo.Approve(a2u(regCallAddr), 1000)

	TransferFromPrev() // amount 1000 fixed
	// P_GRC20_TransferFrom
	// > prevPkg: gno.land/r/demo/regcall
	// > spender(prevAddr): g1mxw23xdar2grl6jt5sgvvxhkh5msjajxf5pfzd
	// > from: g1u7y667z64x2h7vc6fmpcprgey4ck233jaww9zq
	// > to: g1mxw23xdar2grl6jt5sgvvxhkh5msjajxf5pfzd

	// // [u]manfred -> [r]grc20reg -> [r]regcall
}

// // manfred
// // g1u7y667z64x2h7vc6fmpcprgey4ck233jaww9zq

// // regcall
// // g1mxw23xdar2grl6jt5sgvvxhkh5msjajxf5pfzd
