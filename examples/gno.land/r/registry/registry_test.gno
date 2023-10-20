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

var cRealmAddr std.Address

const target string = "g12345"
const fromTo string = "g54321"

func init() {
	cRealmAddr = std.CurrentRealm().Addr()
	// println(cRealmAddr) // g1sqt92sa06ugh8nlt98kyghw83qy84paf4csyh6

	std.TestSetOrigCaller(cRealmAddr)
	foo.Faucet()
	bar.Faucet()
	baz.Faucet()
}

func TestTransferByNameFOO(t *testing.T) {
	if foo.BalanceOf(target) != 0 {
		t.Fatal("target should have 0 FOO but", foo.BalanceOf(target))
	}

	TransferByName("foo", target, 12345)

	if foo.BalanceOf(target) != 12345 {
		t.Fatal("target should have 12345 FOO, but", foo.BalanceOf(target))
	}
}

func TestTransferByNameBAR(t *testing.T) {
	if bar.BalanceOf(target) != 0 {
		t.Fatal("target should have 0 BAR, but", bar.BalanceOf(target))
	}

	TransferByName("bar", target, 12345)

	if bar.BalanceOf(target) != 12345 {
		t.Fatal("target should have 12345 BAR, but", bar.BalanceOf(target))
	}
}

func TestTransferByNameBAZ(t *testing.T) {
	if baz.BalanceOf(target) != 0 {
		t.Fatal("target should have 0 BAZ, but", baz.BalanceOf(target))
	}

	TransferByName("baz", target, 12345)

	if baz.BalanceOf(target) != 12345 {
		t.Fatal("target should have 12345 BAZ, but", baz.BalanceOf(target))
	}
}

func TestTransferFromByNameFOO(t *testing.T) {
	if foo.BalanceOf(fromTo) != 0 {
		t.Fatal("fromTo should have 0 FOO, but", foo.BalanceOf(fromTo))
	}

	std.TestSetOrigCaller(target)
	foo.Approve(users.AddressOrName(cRealmAddr), 5)
	TransferFromByName("foo", target, fromTo, 3)

	if foo.BalanceOf(fromTo) != 3 {
		t.Fatal("fromTo should have 3 FOO, but", foo.BalanceOf(fromTo))
	}

	if foo.BalanceOf(target) != 12342 {
		t.Fatal("target should have 12342 FOO, but", foo.BalanceOf(target))
	}
}

func TestTransferFromByNameBAR(t *testing.T) {
	if bar.BalanceOf(fromTo) != 0 {
		t.Fatal("fromTo should have 0 BAR, but", bar.BalanceOf(fromTo))
	}

	std.TestSetOrigCaller(target)
	bar.Approve(users.AddressOrName(cRealmAddr), 5)
	TransferFromByName("bar", target, fromTo, 3)

	if bar.BalanceOf(fromTo) != 3 {
		t.Fatal("fromTo should have 3 BAR, but", bar.BalanceOf(fromTo))
	}

	if bar.BalanceOf(target) != 12342 {
		t.Fatal("target should have 12342 BAR, but", bar.BalanceOf(target))
	}
}

func TestTransferFromByNameBAZ(t *testing.T) {
	if baz.BalanceOf(fromTo) != 0 {
		t.Fatal("fromTo should have 0 BAZ, but", baz.BalanceOf(fromTo))
	}

	std.TestSetOrigCaller(target)
	baz.Approve(users.AddressOrName(cRealmAddr), 5)
	TransferFromByName("baz", target, fromTo, 3)

	if baz.BalanceOf(fromTo) != 3 {
		t.Fatal("fromTo should have 3 BAZ, but", baz.BalanceOf(fromTo))
	}

	if baz.BalanceOf(target) != 12342 {
		t.Fatal("target should have 12342 BAZ, but", baz.BalanceOf(target))
	}
}
