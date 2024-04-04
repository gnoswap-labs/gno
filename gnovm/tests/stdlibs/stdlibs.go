// Package stdlibs provides supplemental stdlibs for the testing environment.
package stdlibs

import (
	gno "github.com/gnoswap-labs/gno/gnovm/pkg/gnolang"
	"github.com/gnoswap-labs/gno/gnovm/stdlibs"
)

//go:generate go run github.com/gnolang/gno/misc/genstd

func NativeStore(pkgPath string, name gno.Name) func(*gno.Machine) {
	for _, nf := range nativeFuncs {
		if nf.gnoPkg == pkgPath && name == nf.gnoFunc {
			return nf.f
		}
	}
	return stdlibs.NativeStore(pkgPath, name)
}
