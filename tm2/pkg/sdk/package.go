package sdk

import (
	"github.com/gnoswap-labs/gno/tm2/pkg/amino"
	abci "github.com/gnoswap-labs/gno/tm2/pkg/bft/abci/types"
)

var Package = amino.RegisterPackage(amino.NewPackage(
	"github.com/gnoswap-labs/gno/tm2/pkg/sdk",
	"tm",
	amino.GetCallersDirname(),
).
	WithDependencies(
		abci.Package,
	).
	WithTypes(
		Result{},
	))
