package merkle

import (
	amino "github.com/gnoswap-labs/gno/tm2/pkg/amino"
)

var cdc *amino.Codec

func init() {
	cdc = amino.NewCodec()
	cdc.Seal()
}
