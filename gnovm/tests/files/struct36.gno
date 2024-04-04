package main

import (
	"strings"

	"github.com/gnoswap-labs/gno/_test/net/http"
)

type S struct {
	http.Client
}

func main() {
	var s S
	if _, err := s.Get("url"); err != nil {
		println(strings.Contains(err.Error(), "unsupported protocol scheme"))
	}
	return
}

// Output:
// true
