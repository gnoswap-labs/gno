package multisig

import (
	"github.com/gnoswap-labs/gno/tm2/pkg/amino"
)

var Package = amino.RegisterPackage(amino.NewPackage(
	"github.com/gnoswap-labs/gno/tm2/pkg/crypto/multisig",
	"tm",
	amino.GetCallersDirname(),
).WithDependencies().WithTypes(
	PubKeyMultisigThreshold{}, "PubKeyMultisig",
))
