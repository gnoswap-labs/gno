package wrapper

import (
	"gno.land/r/bar"
	"gno.land/r/baz"
	"gno.land/r/foo"
	"gno.land/r/registry"
)

func init() {
	// Transfer
	registry.RegisterTransfer("foo", foo.Transfer)
	registry.RegisterTransfer("bar", bar.Transfer)
	registry.RegisterTransfer("baz", baz.Transfer)

	// TransferFrom
	registry.RegisterTransferFrom("foo", foo.TransferFrom)
	registry.RegisterTransferFrom("bar", bar.TransferFrom)
	registry.RegisterTransferFrom("baz", baz.TransferFrom)
}
