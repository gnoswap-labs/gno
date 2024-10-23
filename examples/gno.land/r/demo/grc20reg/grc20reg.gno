package grc20reg

import (
	"std"

	"gno.land/p/demo/avl"
	"gno.land/p/demo/fqname"
	"gno.land/p/demo/grc/grc20"
	"gno.land/p/demo/ufmt"

	"gno.land/p/demo/grc/grc20"
	"gno.land/p/demo/ownable"
	"gno.land/p/demo/ufmt"
)

var registry = avl.NewTree() // rlmPath[.slug] -> Token

func Register(token grc20.Token, slug string) {
	rlmPath := std.PrevRealm().PkgPath()
	key := fqname.Construct(rlmPath, slug)
	registry.Set(key, token)
	std.Emit(
		registerEvent,
		"pkgpath", rlmPath,
		"slug", slug,
	)
}

func Register2(token grc20.Token, slug string) {
	// dummy
	rlmPath := std.PrevRealm().PkgPath()
	key := fqname.Construct(rlmPath, slug)

	admin := ownable.NewWithAddress("g1u7y667z64x2h7vc6fmpcprgey4ck233jaww9zq") // @manfred
	banker := grc20.NewBanker("Foo", "FOO", 4)
	banker.Mint(admin.Owner(), 1000000*10000) // @administrator (1M)
	dummyToken := banker.Token()

	println("TOKEN")
	println(token)
	println()
	println("DUMMY")
	println(dummyToken)
	println()
	// registry.Set("dummy", dummyToken) // OOO

	// registry.Set("dummy", "token") // OOO

	registry.Set("dummy", token) // XXX
	// registry.Set("dummy", dummyToken) // OOO
}

func Get(key string) grc20.Token {
	token, ok := registry.Get(key)
	if !ok {
		return nil
	}
	return token.(grc20.Token)
}

func MustGet(key string) grc20.Token {
	token := Get(key)
	if token == nil {
		panic("unknown token: " + key)
	}
	return token
}

func Render(path string) string {
	switch {
	case path == "": // home
		// TODO: add pagination
		s := ""
		count := 0
		registry.Iterate("", "", func(key string, tokenI interface{}) bool {
			count++
			token := tokenI.(grc20.Token)
			rlmPath, slug := fqname.Parse(key)
			rlmLink := fqname.RenderLink(rlmPath, slug)
			infoLink := "/r/demo/grc20reg:" + key
			s += ufmt.Sprintf("- **%s** - %s - [info](%s)\n", token.GetName(), rlmLink, infoLink)
			return false
		})
		if count == 0 {
			return "No registered token."
		}
		return s
	default: // specific token
		key := path
		token := MustGet(key)
		rlmPath, slug := fqname.Parse(key)
		rlmLink := fqname.RenderLink(rlmPath, slug)
		s := ufmt.Sprintf("# %s\n", token.GetName())
		s += ufmt.Sprintf("- symbol: **%s**\n", token.GetSymbol())
		s += ufmt.Sprintf("- realm: %s\n", rlmLink)
		s += ufmt.Sprintf("- decimals: %d\n", token.GetDecimals())
		s += ufmt.Sprintf("- total supply: %d\n", token.TotalSupply())
		return s
	}
}

const registerEvent = "register"
