package keys

import (
	"github.com/gnoswap-labs/gno/tm2/pkg/amino"
)

var Package = amino.RegisterPackage(amino.NewPackage(
	"github.com/gnoswap-labs/gno/tm2/pkg/crypto/keys",
	"tm.keys",
	amino.GetCallersDirname(),
).WithDependencies().WithTypes(
	localInfo{}, "LocalInfo",
	ledgerInfo{}, "LedgerInfo",
	offlineInfo{}, "OfflineInfo",
	multiInfo{}, "MultiInfo",
))
