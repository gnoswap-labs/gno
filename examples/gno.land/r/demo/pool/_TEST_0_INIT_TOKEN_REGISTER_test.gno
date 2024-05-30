package pool

import (
	"std"

	"gno.land/r/demo/bar"
	"gno.land/r/demo/baz"
	"gno.land/r/demo/foo"
	"gno.land/r/demo/gns"
	"gno.land/r/demo/obl"
	"gno.land/r/demo/qux"
	"gno.land/r/demo/wugnot"

	"gno.land/r/demo/test01"
	"gno.land/r/demo/test02"
	"gno.land/r/demo/test03"
	"gno.land/r/demo/test04"
	"gno.land/r/demo/test05"
	"gno.land/r/demo/test06"
	"gno.land/r/demo/test07"

	"gno.land/r/demo/gnoswap/consts"

	pusers "gno.land/p/demo/users"
)

type FooToken struct{}

func (FooToken) Transfer() func(to pusers.AddressOrName, amount uint64) {
	return foo.Transfer
}
func (FooToken) TransferFrom() func(from, to pusers.AddressOrName, amount uint64) {
	return foo.TransferFrom
}
func (FooToken) BalanceOf() func(owner pusers.AddressOrName) uint64 {
	return foo.BalanceOf
}
func (FooToken) Approve() func(spender pusers.AddressOrName, amount uint64) {
	return foo.Approve
}

type BarToken struct{}

func (BarToken) Transfer() func(to pusers.AddressOrName, amount uint64) {
	return bar.Transfer
}
func (BarToken) TransferFrom() func(from, to pusers.AddressOrName, amount uint64) {
	return bar.TransferFrom
}
func (BarToken) BalanceOf() func(owner pusers.AddressOrName) uint64 {
	return bar.BalanceOf
}
func (BarToken) Approve() func(spender pusers.AddressOrName, amount uint64) {
	return bar.Approve
}

type BazToken struct{}

func (BazToken) Transfer() func(to pusers.AddressOrName, amount uint64) {
	return baz.Transfer
}
func (BazToken) TransferFrom() func(from, to pusers.AddressOrName, amount uint64) {
	return baz.TransferFrom
}
func (BazToken) BalanceOf() func(owner pusers.AddressOrName) uint64 {
	return baz.BalanceOf
}
func (BazToken) Approve() func(spender pusers.AddressOrName, amount uint64) {
	return baz.Approve
}

type QuxToken struct{}

func (QuxToken) Transfer() func(to pusers.AddressOrName, amount uint64) {
	return qux.Transfer
}
func (QuxToken) TransferFrom() func(from, to pusers.AddressOrName, amount uint64) {
	return qux.TransferFrom
}
func (QuxToken) BalanceOf() func(owner pusers.AddressOrName) uint64 {
	return qux.BalanceOf
}
func (QuxToken) Approve() func(spender pusers.AddressOrName, amount uint64) {
	return qux.Approve
}

type WugnotToken struct{}

func (WugnotToken) Transfer() func(to pusers.AddressOrName, amount uint64) {
	return wugnot.Transfer
}
func (WugnotToken) TransferFrom() func(from, to pusers.AddressOrName, amount uint64) {
	return wugnot.TransferFrom
}
func (WugnotToken) BalanceOf() func(owner pusers.AddressOrName) uint64 {
	return wugnot.BalanceOf
}
func (WugnotToken) Approve() func(spender pusers.AddressOrName, amount uint64) {
	return wugnot.Approve
}

type OBLToken struct{}

func (OBLToken) Transfer() func(to pusers.AddressOrName, amount uint64) {
	return obl.Transfer
}
func (OBLToken) TransferFrom() func(from, to pusers.AddressOrName, amount uint64) {
	return obl.TransferFrom
}
func (OBLToken) BalanceOf() func(owner pusers.AddressOrName) uint64 {
	return obl.BalanceOf
}
func (OBLToken) Approve() func(spender pusers.AddressOrName, amount uint64) {
	return obl.Approve
}

type GNSToken struct{}

func (GNSToken) Transfer() func(to pusers.AddressOrName, amount uint64) {
	return gns.Transfer
}

func (GNSToken) TransferFrom() func(from, to pusers.AddressOrName, amount uint64) {
	return gns.TransferFrom
}

func (GNSToken) BalanceOf() func(owner pusers.AddressOrName) uint64 {
	return gns.BalanceOf
}

func (GNSToken) Approve() func(spender pusers.AddressOrName, amount uint64) {
	return gns.Approve
}

type Test01Token struct{}

func (Test01Token) Transfer() func(to pusers.AddressOrName, amount uint64) {
	return test01.Transfer
}

func (Test01Token) TransferFrom() func(from, to pusers.AddressOrName, amount uint64) {
	return test01.TransferFrom
}

func (Test01Token) BalanceOf() func(owner pusers.AddressOrName) uint64 {
	return test01.BalanceOf
}

func (Test01Token) Approve() func(spender pusers.AddressOrName, amount uint64) {
	return test01.Approve
}

type Test02Token struct{}

func (Test02Token) Transfer() func(to pusers.AddressOrName, amount uint64) {
	return test02.Transfer
}

func (Test02Token) TransferFrom() func(from, to pusers.AddressOrName, amount uint64) {
	return test02.TransferFrom
}

func (Test02Token) BalanceOf() func(owner pusers.AddressOrName) uint64 {
	return test02.BalanceOf
}

func (Test02Token) Approve() func(spender pusers.AddressOrName, amount uint64) {
	return test02.Approve
}

type Test03Token struct{}

func (Test03Token) Transfer() func(to pusers.AddressOrName, amount uint64) {
	return test03.Transfer
}

func (Test03Token) TransferFrom() func(from, to pusers.AddressOrName, amount uint64) {
	return test03.TransferFrom
}

func (Test03Token) BalanceOf() func(owner pusers.AddressOrName) uint64 {
	return test03.BalanceOf
}

func (Test03Token) Approve() func(spender pusers.AddressOrName, amount uint64) {
	return test03.Approve
}

type Test04Token struct{}

func (Test04Token) Transfer() func(to pusers.AddressOrName, amount uint64) {
	return test04.Transfer
}

func (Test04Token) TransferFrom() func(from, to pusers.AddressOrName, amount uint64) {
	return test04.TransferFrom
}

func (Test04Token) BalanceOf() func(owner pusers.AddressOrName) uint64 {
	return test04.BalanceOf
}

func (Test04Token) Approve() func(spender pusers.AddressOrName, amount uint64) {
	return test04.Approve
}

type Test05Token struct{}

func (Test05Token) Transfer() func(to pusers.AddressOrName, amount uint64) {
	return test05.Transfer
}

func (Test05Token) TransferFrom() func(from, to pusers.AddressOrName, amount uint64) {
	return test05.TransferFrom
}

func (Test05Token) BalanceOf() func(owner pusers.AddressOrName) uint64 {
	return test05.BalanceOf
}

func (Test05Token) Approve() func(spender pusers.AddressOrName, amount uint64) {
	return test05.Approve
}

type Test06Token struct{}

func (Test06Token) Transfer() func(to pusers.AddressOrName, amount uint64) {
	return test06.Transfer
}

func (Test06Token) TransferFrom() func(from, to pusers.AddressOrName, amount uint64) {
	return test06.TransferFrom
}

func (Test06Token) BalanceOf() func(owner pusers.AddressOrName) uint64 {
	return test06.BalanceOf
}

func (Test06Token) Approve() func(spender pusers.AddressOrName, amount uint64) {
	return test06.Approve
}

type Test07Token struct{}

func (Test07Token) Transfer() func(to pusers.AddressOrName, amount uint64) {
	return test07.Transfer
}

func (Test07Token) TransferFrom() func(from, to pusers.AddressOrName, amount uint64) {
	return test07.TransferFrom
}

func (Test07Token) BalanceOf() func(owner pusers.AddressOrName) uint64 {
	return test07.BalanceOf
}

func (Test07Token) Approve() func(spender pusers.AddressOrName, amount uint64) {
	return test07.Approve
}

func init() {
	std.TestSetOrigCaller(consts.GNOSWAP_ADMIN)

	RegisterGRC20Interface("gno.land/r/demo/bar", BarToken{})
	RegisterGRC20Interface("gno.land/r/demo/foo", FooToken{})
	RegisterGRC20Interface("gno.land/r/demo/baz", BazToken{})
	RegisterGRC20Interface("gno.land/r/demo/qux", QuxToken{})
	RegisterGRC20Interface("gno.land/r/demo/wugnot", WugnotToken{})
	RegisterGRC20Interface("gno.land/r/demo/obl", OBLToken{})
	RegisterGRC20Interface("gno.land/r/demo/gns", GNSToken{})

	RegisterGRC20Interface("gno.land/r/demo/test01", Test01Token{})
	RegisterGRC20Interface("gno.land/r/demo/test02", Test02Token{})
	RegisterGRC20Interface("gno.land/r/demo/test03", Test03Token{})
	RegisterGRC20Interface("gno.land/r/demo/test04", Test04Token{})
	RegisterGRC20Interface("gno.land/r/demo/test05", Test05Token{})
	RegisterGRC20Interface("gno.land/r/demo/test06", Test06Token{})
	RegisterGRC20Interface("gno.land/r/demo/test07", Test07Token{})

}
