package wrapper

import (
	"gno.land/r/bar"
	"gno.land/r/baz"
	"gno.land/r/demo/users"
	"gno.land/r/foo"
	"gno.land/r/registry"
)

type FooTokenInterface struct{}

func (FooTokenInterface) Transfer() func(to users.AddressOrName, amount uint64) {
	return foo.Transfer
}

func (FooTokenInterface) TransferFrom() func(from, to users.AddressOrName, amount uint64) {
	return foo.TransferFrom
}

var _ registry.GRC20Interface = FooTokenInterface{}

type BarTokenInterface struct{}

func (BarTokenInterface) Transfer() func(to users.AddressOrName, amount uint64) {
	return bar.Transfer
}

func (BarTokenInterface) TransferFrom() func(from, to users.AddressOrName, amount uint64) {
	return bar.TransferFrom
}

var _ registry.GRC20Interface = BarTokenInterface{}

type BazTokenInterface struct{}

func (BazTokenInterface) Transfer() func(to users.AddressOrName, amount uint64) {
	return baz.Transfer
}

func (BazTokenInterface) TransferFrom() func(from, to users.AddressOrName, amount uint64) {
	return baz.TransferFrom
}

var _ registry.GRC20Interface = BazTokenInterface{}

func init() {
	registry.RegisterGRC20Interface("gno.land/r/foo", FooTokenInterface{})
	registry.RegisterGRC20Interface("gno.land/r/bar", BarTokenInterface{})
	registry.RegisterGRC20Interface("gno.land/r/baz", BazTokenInterface{})
}
