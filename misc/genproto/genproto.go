package main

import (
	"context"
	"os"

	"github.com/gnoswap-labs/gno/tm2/pkg/amino"
	"github.com/gnoswap-labs/gno/tm2/pkg/amino/genproto"
	"github.com/gnoswap-labs/gno/tm2/pkg/amino/tests"
	"github.com/gnoswap-labs/gno/tm2/pkg/commands"

	// TODO: move these out.
	"github.com/gnoswap-labs/gno/gno.land/pkg/sdk/vm"
	gno "github.com/gnoswap-labs/gno/gnovm/pkg/gnolang"
	abci "github.com/gnoswap-labs/gno/tm2/pkg/bft/abci/types"
	"github.com/gnoswap-labs/gno/tm2/pkg/bft/blockchain"
	"github.com/gnoswap-labs/gno/tm2/pkg/bft/consensus"
	ctypes "github.com/gnoswap-labs/gno/tm2/pkg/bft/consensus/types"
	"github.com/gnoswap-labs/gno/tm2/pkg/bft/mempool"
	btypes "github.com/gnoswap-labs/gno/tm2/pkg/bft/types"
	"github.com/gnoswap-labs/gno/tm2/pkg/bitarray"
	"github.com/gnoswap-labs/gno/tm2/pkg/crypto/ed25519"
	"github.com/gnoswap-labs/gno/tm2/pkg/crypto/hd"
	"github.com/gnoswap-labs/gno/tm2/pkg/crypto/merkle"
	"github.com/gnoswap-labs/gno/tm2/pkg/crypto/multisig"
	"github.com/gnoswap-labs/gno/tm2/pkg/sdk"
	"github.com/gnoswap-labs/gno/tm2/pkg/sdk/bank"
	"github.com/gnoswap-labs/gno/tm2/pkg/std"
)

func main() {
	cmd := commands.NewCommand(
		commands.Metadata{
			LongHelp: "Generates proto bindings for Amino packages",
		},
		commands.NewEmptyConfig(),
		execGen,
	)

	cmd.Execute(context.Background(), os.Args[1:])
}

func execGen(_ context.Context, _ []string) error {
	pkgs := []*amino.Package{
		bitarray.Package,
		merkle.Package,
		abci.Package,
		btypes.Package,
		consensus.Package,
		ctypes.Package,
		mempool.Package,
		ed25519.Package,
		blockchain.Package,
		hd.Package,
		multisig.Package,
		std.Package,
		sdk.Package,
		bank.Package,
		vm.Package,
		gno.Package,
		tests.Package,
	}

	for _, pkg := range pkgs {
		genproto.WriteProto3Schema(pkg)
		genproto.WriteProtoBindings(pkg)
		genproto.MakeProtoFolder(pkg, "proto")
	}

	for _, pkg := range pkgs {
		genproto.RunProtoc(pkg, "proto")
	}

	return nil
}
