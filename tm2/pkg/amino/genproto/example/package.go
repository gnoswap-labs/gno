package main

import (
	"github.com/gnoswap-labs/gno/tm2/pkg/amino"
	"github.com/gnoswap-labs/gno/tm2/pkg/amino/genproto/example/submodule"
)

var Package = amino.RegisterPackage(
	amino.NewPackage(
		"main",
		"main",
		amino.GetCallersDirname(),
	).WithP3GoPkgPath(
		"github.com/gnoswap-labs/gno/tm2/pkg/amino/genproto/example/pb",
	).WithDependencies(
		submodule.Package,
	).WithTypes(
		StructA{},
		StructB{},
	),
)
