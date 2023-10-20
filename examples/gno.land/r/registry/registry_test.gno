package registry

import (
	"std"
	"testing"

	"gno.land/r/bar"
	"gno.land/r/baz"
	"gno.land/r/foo"

	"gno.land/r/demo/users"

	_ "gno.land/r/wrapper"
)

const (
	transferTo       string = "g12345"
	transferFromFrom string = "g12345"

	transferFromTo string = "g54321"
)

var cRealmAddr std.Address

func init() {
	cRealmAddr = std.CurrentRealm().Addr()

	std.TestSetOrigCaller(cRealmAddr)
	foo.Faucet()
	bar.Faucet()
	baz.Faucet()
}

func TestTransferByNameFOO(t *testing.T) {
	if foo.BalanceOf(transferTo) != 0 {
		t.Fatal("transferTo should have 0 FOO but", foo.BalanceOf(transferTo))
	}

	TransferByInterfaceName("gno.land/r/foo", transferTo, 12345)

	if foo.BalanceOf(transferTo) != 12345 {
		t.Fatal("transferTo should have 12345 FOO, but", foo.BalanceOf(transferTo))
	}
}

func TestTransferByNameBAR(t *testing.T) {
	if bar.BalanceOf(transferTo) != 0 {
		t.Fatal("transferTo should have 0 BAR, but", bar.BalanceOf(transferTo))
	}

	TransferByInterfaceName("gno.land/r/bar", transferTo, 12345)

	if bar.BalanceOf(transferTo) != 12345 {
		t.Fatal("transferTo should have 12345 BAR, but", bar.BalanceOf(transferTo))
	}
}

func TestTransferByNameBAZ(t *testing.T) {
	if baz.BalanceOf(transferTo) != 0 {
		t.Fatal("transferTo should have 0 BAZ, but", baz.BalanceOf(transferTo))
	}

	TransferByInterfaceName("gno.land/r/baz", transferTo, 12345)

	if baz.BalanceOf(transferTo) != 12345 {
		t.Fatal("transferTo should have 12345 BAZ, but", baz.BalanceOf(transferTo))
	}
}

func TestTransferFromByNameFOO(t *testing.T) {
	if foo.BalanceOf(transferFromTo) != 0 {
		t.Fatal("transferFromTo should have 0 FOO, but", foo.BalanceOf(transferFromTo))
	}

	std.TestSetOrigCaller(transferFromFrom)
	foo.Approve(users.AddressOrName(cRealmAddr), 5)
	TransferFromByInterfaceName("gno.land/r/foo", transferFromFrom, transferFromTo, 3)

	if foo.BalanceOf(transferFromTo) != 3 {
		t.Fatal("transferFromTo should have 3 FOO, but", foo.BalanceOf(transferFromTo))
	}

	if foo.BalanceOf(transferFromFrom) != 12342 {
		t.Fatal("transferFromFrom should have 12342 FOO, but", foo.BalanceOf(transferFromFrom))
	}
}

func TestTransferFromByNameBAR(t *testing.T) {
	if bar.BalanceOf(transferFromTo) != 0 {
		t.Fatal("transferFromTo should have 0 BAR, but", bar.BalanceOf(transferFromTo))
	}

	std.TestSetOrigCaller(transferFromFrom)
	bar.Approve(users.AddressOrName(cRealmAddr), 5)
	TransferFromByInterfaceName("gno.land/r/bar", transferFromFrom, transferFromTo, 3)

	if bar.BalanceOf(transferFromTo) != 3 {
		t.Fatal("transferFromTo should have 3 BAR, but", bar.BalanceOf(transferFromTo))
	}

	if bar.BalanceOf(transferFromFrom) != 12342 {
		t.Fatal("transferFromFrom should have 12342 BAR, but", bar.BalanceOf(transferFromFrom))
	}
}

func TestTransferFromByNameBAZ(t *testing.T) {
	if baz.BalanceOf(transferFromTo) != 0 {
		t.Fatal("transferFromTo should have 0 BAZ, but", baz.BalanceOf(transferFromTo))
	}

	std.TestSetOrigCaller(transferFromFrom)
	baz.Approve(users.AddressOrName(cRealmAddr), 5)
	TransferFromByInterfaceName("gno.land/r/baz", transferFromFrom, transferFromTo, 3)

	if baz.BalanceOf(transferFromTo) != 3 {
		t.Fatal("transferFromTo should have 3 BAZ, but", baz.BalanceOf(transferFromTo))
	}

	if baz.BalanceOf(transferFromFrom) != 12342 {
		t.Fatal("transferFromFrom should have 12342 BAZ, but", baz.BalanceOf(transferFromFrom))
	}
}

func TestUnregisterUnauthorized(t *testing.T) {
	shouldPanic(t, func() { UnregisterGRC20Interface("gno.land/r/foo") })
}

func TestUnregisterAuthorized(t *testing.T) {
	if len(registered) != 3 {
		t.Fatal("should have 3 registered interfaces")
	}

	std.TestSetOrigCaller("g1sqt92sa06ugh8nlt98kyghw83qy84paf4csyh6")
	UnregisterGRC20Interface("gno.land/r/foo")

	if len(registered) != 2 {
		t.Fatal("should have 2 registered interfaces")
	}
}

func shouldPanic(t *testing.T, f func()) {
	defer func() {
		if r := recover(); r == nil {
			t.Errorf("expected panic")
		}
	}()
	f()
}
