package foo

import "github.com/gnoswap-labs/gno/_test/foo/boo"

var (
	Bar = "BARR"
	Boo = boo.Boo
)

func init() { println("init foo") }
