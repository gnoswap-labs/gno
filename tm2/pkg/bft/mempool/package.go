package mempool

import (
	"github.com/gnoswap-labs/gno/tm2/pkg/amino"
)

var Package = amino.RegisterPackage(amino.NewPackage(
	"github.com/gnoswap-labs/gno/tm2/pkg/bft/mempool",
	"tm",
	amino.GetCallersDirname(),
).WithDependencies().WithTypes(
	&TxMessage{},
))
