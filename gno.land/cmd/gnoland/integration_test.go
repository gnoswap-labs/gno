package main

import (
	"testing"

	"github.com/gnoswap-labs/gno/gno.land/pkg/integration"
)

func TestTestdata(t *testing.T) {
	integration.RunGnolandTestscripts(t, "testdata")
}
