package bank

// DONTCOVER

import (
	bft "github.com/gnoswap-labs/gno/tm2/pkg/bft/types"
	"github.com/gnoswap-labs/gno/tm2/pkg/db/memdb"
	"github.com/gnoswap-labs/gno/tm2/pkg/log"

	"github.com/gnoswap-labs/gno/tm2/pkg/sdk"
	"github.com/gnoswap-labs/gno/tm2/pkg/sdk/auth"
	"github.com/gnoswap-labs/gno/tm2/pkg/std"
	"github.com/gnoswap-labs/gno/tm2/pkg/store"
	"github.com/gnoswap-labs/gno/tm2/pkg/store/iavl"
)

type testEnv struct {
	ctx  sdk.Context
	bank BankKeeper
	acck auth.AccountKeeper
}

func setupTestEnv() testEnv {
	db := memdb.NewMemDB()

	authCapKey := store.NewStoreKey("authCapKey")

	ms := store.NewCommitMultiStore(db)
	ms.MountStoreWithDB(authCapKey, iavl.StoreConstructor, db)
	ms.LoadLatestVersion()

	ctx := sdk.NewContext(sdk.RunTxModeDeliver, ms, &bft.Header{ChainID: "test-chain-id"}, log.NewNoopLogger())
	acck := auth.NewAccountKeeper(
		authCapKey, std.ProtoBaseAccount,
	)

	bank := NewBankKeeper(acck)

	return testEnv{ctx: ctx, bank: bank, acck: acck}
}
