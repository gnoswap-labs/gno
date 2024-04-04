package main

import _ "github.com/gnoswap-labs/gno/_test/redeclaration3"

func main() {
	println("should not happen")
}

// XXX show what was redeclared.

// Error:
// running package "github.com/gnoswap-labs/gno/_test/redeclaration3": duplicate declarations not allowed
