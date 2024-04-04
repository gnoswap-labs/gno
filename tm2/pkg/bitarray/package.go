package bitarray

import "github.com/gnoswap-labs/gno/tm2/pkg/amino"

var Package = amino.RegisterPackage(amino.NewPackage(
	"github.com/gnoswap-labs/gno/tm2/pkg/bitarray",
	"tm",
	amino.GetCallersDirname(),
).WithDependencies().WithTypes(
	BitArray{}, "BitArray",
))
