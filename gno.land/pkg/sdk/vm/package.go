package vm

import (
	"github.com/gnoswap-labs/gno/tm2/pkg/amino"
	"github.com/gnoswap-labs/gno/tm2/pkg/std"
)

var Package = amino.RegisterPackage(amino.NewPackage(
	"github.com/gnoswap-labs/gno/gno.land/pkg/sdk/vm",
	"vm",
	amino.GetCallersDirname(),
).WithDependencies(
	std.Package,
).WithTypes(
	MsgCall{}, "m_call",
	MsgRun{}, "m_run",
	MsgAddPackage{}, "m_addpkg", // TODO rename both to MsgAddPkg?

	// errors
	InvalidPkgPathError{}, "InvalidPkgPathError",
	InvalidStmtError{}, "InvalidStmtError",
	InvalidExprError{}, "InvalidExprError",
))
