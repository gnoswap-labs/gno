// PKGPATH: gno.land/r/r3v4/ra
package rb

import (
	"std"
	"testing"

	"gno.land/p/demo/testutils"
)

func Test_TestSetPrevRealm(t *testing.T) {
	std.TestSetPrevRealm("gno.land/r/demo/thisgoes")
	Info()
}

func Test_TestSetPrevAddr(t *testing.T) {
	dummy := testutils.TestAddress("dummy")
	std.TestSetPrevAddr(dummy)
	Info()
}
