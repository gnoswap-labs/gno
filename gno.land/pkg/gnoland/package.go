package gnoland

import (
	"github.com/gnoswap-labs/gno/tm2/pkg/amino"
)

var Package = amino.RegisterPackage(amino.NewPackage(
	"github.com/gnoswap-labs/gno/gno.land/pkg/gnoland",
	"gno",
	amino.GetCallersDirname(),
).WithDependencies().WithTypes(
	&GnoAccount{}, "Account",
	GnoGenesisState{}, "GenesisState",
))
