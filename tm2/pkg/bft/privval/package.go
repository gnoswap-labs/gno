package privval

import (
	"github.com/gnoswap-labs/gno/tm2/pkg/amino"
)

var Package = amino.RegisterPackage(amino.NewPackage(
	"github.com/gnoswap-labs/gno/tm2/pkg/bft/privval",
	"tm.remotesigner",
	amino.GetCallersDirname(),
).
	WithDependencies().
	WithTypes(

		// Remote Signer
		&PubKeyRequest{},
		&PubKeyResponse{},
		&SignVoteRequest{},
		&SignedVoteResponse{},
		&SignProposalRequest{},
		&SignedProposalResponse{},
		&PingRequest{},
		&PingResponse{},
	))
