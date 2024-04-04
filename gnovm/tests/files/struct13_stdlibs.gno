package main

import (
	"fmt"

	"github.com/gnoswap-labs/gno/_test/net/http"
)

type Fromage struct {
	http.Server
}

func main() {
	a := Fromage{}
	fmt.Println(a.Server.WriteTimeout)
}

// Output:
// 0
