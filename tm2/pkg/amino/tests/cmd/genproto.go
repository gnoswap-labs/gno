package main

import (
	"github.com/gnoswap-labs/gno/tm2/pkg/amino/genproto"
	"github.com/gnoswap-labs/gno/tm2/pkg/amino/tests"
)

func main() {
	pkg := tests.Package
	genproto.WriteProto3Schema(pkg)
	genproto.MakeProtoFolder(pkg, "proto")
	genproto.RunProtoc(pkg, "proto")
	genproto.WriteProtoBindings(pkg)
}
