package registry

import (
	"gno.land/r/demo/users"
)

var registered = []grc20Pair{}

type grc20TransferCb func(to users.AddressOrName, amount uint64)
type grc20TransferFromCb func(from, to users.AddressOrName, amount uint64)
type grc20Pair struct { /// xxx: map
	name           string // xxx: realm_path
	transferCb     grc20TransferCb
	transferFromCb grc20TransferFromCb
}

func RegisterTransfer(name string, cb grc20TransferCb) {
	if len(registered) == 0 {
		registered = append(registered, grc20Pair{name: name, transferCb: cb})
	} else {
		for i, pair := range registered {
			if pair.name == name {
				registered[i].transferCb = cb
			} else { // new found
				registered = append(registered, grc20Pair{name: name, transferCb: cb})
			}
		}
	}
}

func RegisterTransferFrom(name string, cb grc20TransferFromCb) {
	if len(registered) == 0 {
		registered = append(registered, grc20Pair{name: name, transferFromCb: cb})
	} else {
		for i, pair := range registered {
			if pair.name == name {
				registered[i].transferFromCb = cb
			} else { // new found
				registered = append(registered, grc20Pair{name: name, transferFromCb: cb})
			}
		}
	}

}

func TransferByName(name string, to string, amount uint64) bool {
	for i, pair := range registered {
		if pair.name == name { // if token is registered
			pair.transferCb(users.AddressOrName(to), amount)
			return true
		}
	}

	return false
}

func TransferFromByName(name string, from, to string, amount uint64) bool {
	for _, pair := range registered {
		if pair.name == name { // if token is registered
			pair.transferFromCb(users.AddressOrName(from), users.AddressOrName(to), amount)
			return true
		}
	}

	return false
}
