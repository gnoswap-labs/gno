package main

import "github.com/gnoswap-labs/gno/_test/c1"

func main() {
	println(c1.C1)
}

// Error:
// github.com/gnolang/gno/_test/c2/c2.gno:1: import cycle detected: "github.com/gnoswap-labs/gno/_test/c1"
