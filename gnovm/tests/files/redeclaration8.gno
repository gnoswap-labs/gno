package main

import _ "github.com/gnoswap-labs/gno/_test/redeclaration2"

func main() {
	println("should not happen")
}

// XXX show what was redeclared.

// Error:
// running package "github.com/gnoswap-labs/gno/_test/redeclaration2": duplicate declarations not allowed
