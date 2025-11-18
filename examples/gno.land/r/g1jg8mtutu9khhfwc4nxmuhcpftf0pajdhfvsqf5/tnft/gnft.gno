package tnft

import (
	"std"

	"gno.land/p/demo/tokens/grc721"
	"gno.land/p/nt/ownable"
	"gno.land/p/nt/ufmt"
)

var (
	nft   = grc721.NewBasicNFT("Test NFT", "TNFT")
	owner = ownable.NewWithAddress(std.PreviousRealm().Address())
)

// BulkMint mints a bulk of tokens to the specified address.
// For testing purposes, the bulk size is set to bulkSize.
// This function is not intended to be used in production.
func BulkMint(cur realm, to address, bulkSize int64) {
	for i := int64(0); i < bulkSize; i++ {
		nextTokenId := nft.TokenCount() + i + 1
		tid := grc721.TokenID(ufmt.Sprintf("%d", nextTokenId))

		err := nft.Mint(to, tid)
		if err != nil {
			panic(err)
		}

		tokenURI := genImageURI(generateRandInstance())
		err = setTokenURI(tid, grc721.TokenURI(tokenURI))
		if err != nil {
			panic(err)
		}
	}
}

// setTokenURI sets the metadata URI for a specific token ID.
func setTokenURI(tid grc721.TokenID, tURI grc721.TokenURI) error {
	_, err := nft.SetTokenURI(tid, tURI)
	if err != nil {
		return ufmt.Errorf("token id (%s) || %s", tid, err.Error())
	}

	return nil
}
