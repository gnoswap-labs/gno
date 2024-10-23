package regcall

import (
	"std"
	"testing"

	"gno.land/r/demo/foo"
)

var (
	manfredAddr  = std.Address("g1u7y667z64x2h7vc6fmpcprgey4ck233jaww9zq")
	manfredRealm = std.NewUserRealm(manfredAddr)

	regCallAddr = std.Address("g1mxw23xdar2grl6jt5sgvvxhkh5msjajxf5pfzd")
	regCallPath = "gno.land/r/demo/regcall"
)

func TestTransferFromPrev(t *testing.T) {
	// approve using grc20reg  // only code level (works fine)
	// fooToken := reg.MustGet("gno.land/r/demo/foo")
	// std.TestSetRealm(manfredRealm)
	// checkErr(fooToken.Approve(regCallAddr, 1000))

	// approve using import // code + (offchain) level (doesn't work)
	std.TestSetRealm(manfredRealm)
	foo.Approve(a2u(regCallAddr), 1000)

	TransferFromPrev() // amount 1000 fixed
}
