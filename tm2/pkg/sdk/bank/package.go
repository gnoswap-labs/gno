package bank

import (
	"github.com/gnoswap-labs/gno/tm2/pkg/amino"
)

var Package = amino.RegisterPackage(amino.NewPackage(
	"github.com/gnoswap-labs/gno/tm2/pkg/sdk/bank",
	"bank",
	amino.GetCallersDirname(),
).WithDependencies().WithTypes(
	NoInputsError{}, "NoInputsError",
	NoOutputsError{}, "NoOutputsError",
	InputOutputMismatchError{}, "InputOutputMismatchError",
	MsgSend{}, "MsgSend",
))
