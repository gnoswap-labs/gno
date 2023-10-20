package registry

import (
	"gno.land/r/demo/users"
)

var registered = []GRC20Pair{}

type GRC20Interface interface {
	Transfer() func(to users.AddressOrName, amount uint64)
	TransferFrom() func(from, to users.AddressOrName, amount uint64)
}

type GRC20Pair struct {
	name  string
	grc20 GRC20Interface
}

func findGRC20(name string) (int, bool) {
	for i, pair := range registered {
		if pair.name == name {
			return i, true
		}
	}

	return -1, false
}

func appendGRC20(name string, grc20 GRC20Interface) {
	registered = append(registered, GRC20Pair{name: name, grc20: grc20})
}

func RegisterGRC20Interface(name string, grc20 GRC20Interface) {
	_, found := findGRC20(name)
	if found {
		panic("GRC20 already registered")
	}

	appendGRC20(name, grc20)
}

func TransferByName(name string, to string, amount uint64) bool {
	i, found := findGRC20(name)
	if !found {
		return false
	}

	registered[i].grc20.Transfer()(users.AddressOrName(to), amount)

	return true
}

func TransferFromByName(name string, from, to string, amount uint64) bool {
	i, found := findGRC20(name)
	if !found {
		return false
	}

	registered[i].grc20.TransferFrom()(users.AddressOrName(from), users.AddressOrName(to), amount)

	return true
}
