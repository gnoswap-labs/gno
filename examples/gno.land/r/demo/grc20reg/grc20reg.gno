package grc20reg

import (
	"std"

	"gno.land/p/demo/fqname"
	"gno.land/p/demo/grc/grc20"
	"gno.land/p/demo/ufmt"

	"gno.land/p/demo/grc/grc20"
	"gno.land/p/demo/ufmt"
)

// var registry = avl.NewTree() // rlmPath[.slug] -> Token
var registry = make(map[string]grc20.Token)

func Register(token grc20.Token, slug string) {
	println("grc20reg__Register()")
	rlmPath := std.PrevRealm().PkgPath()
	key := fqname.Construct(rlmPath, slug)

	registry[key] = token
	// registry.Set(key, token)
	// token.TotalSupply()
	// registry.Set("k", "t")

	std.Emit(
		registerEvent,
		"pkgpath", rlmPath,
		"slug", slug,
	)

	curr := std.CurrentRealm()
	println("currPath:", curr.PkgPath())
	println("currAddr:", curr.Addr())
	prev := std.PrevRealm()
	println("prevPath:", prev.PkgPath())
	println("prevAddr:", prev.Addr())
	println()

}

func Get(key string) grc20.Token {
	// token, ok := registry.Get(key)
	// if !ok {
	// 	return nil
	// }
	token, ok := registry[key]
	if !ok {
		return nil
	}
	return token
}

func MustGet(key string) grc20.Token {
	// token := Get(key)
	// if token == nil {
	// 	panic("unknown token: " + key)
	// }
	token, ok := registry[key]
	if !ok {
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
		for key, token := range registry {
			count++
			rlmPath, slug := fqname.Parse(key)
			rlmLink := fqname.RenderLink(rlmPath, slug)
			infoLink := "/r/demo/grc20reg:" + key
			s += ufmt.Sprintf("- **%s** - %s - [info](%s)\n", token.GetName(), rlmLink, infoLink)
		}
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
