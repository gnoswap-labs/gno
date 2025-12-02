package gnolang

import (
	"fmt"
	"strings"
)

// FunctionGasInfo tracks gas consumption for a single function
type FunctionGasInfo struct {
	Name      string
	PkgPath   string
	StartGas  int64
	EndGas    int64
	Consumed  int64
	CallCount int
}

// GasTracker tracks gas consumption per function
type GasTracker struct {
	enabled       bool
	functions     map[string]*FunctionGasInfo
	callStack     []string
	currentGas    int64
}

// NewGasTracker creates a new gas tracker
func NewGasTracker(enabled bool) *GasTracker {
	return &GasTracker{
		enabled:   enabled,
		functions: make(map[string]*FunctionGasInfo),
		callStack: make([]string, 0),
	}
}

// EnterFunction tracks entering a function
func (gt *GasTracker) EnterFunction(name, pkgPath string, currentGas int64) {
	if !gt.enabled {
		return
	}
	
	key := fmt.Sprintf("%s.%s", pkgPath, name)
	gt.callStack = append(gt.callStack, key)
	
	if info, exists := gt.functions[key]; exists {
		info.CallCount++
		info.StartGas = currentGas
	} else {
		gt.functions[key] = &FunctionGasInfo{
			Name:      name,
			PkgPath:   pkgPath,
			StartGas:  currentGas,
			CallCount: 1,
		}
	}
}

// ExitFunction tracks exiting a function
func (gt *GasTracker) ExitFunction(currentGas int64) {
	if !gt.enabled || len(gt.callStack) == 0 {
		return
	}
	
	// Pop from call stack
	key := gt.callStack[len(gt.callStack)-1]
	gt.callStack = gt.callStack[:len(gt.callStack)-1]
	
	if info, exists := gt.functions[key]; exists {
		info.EndGas = currentGas
		consumed := currentGas - info.StartGas
		info.Consumed += consumed
	}
}

// GetReport returns a formatted report of gas consumption per function
func (gt *GasTracker) GetReport() string {
	if !gt.enabled {
		return ""
	}
	
	var sb strings.Builder
	sb.WriteString("\n[GAS REPORT] Function Gas Consumption:\n")
	sb.WriteString("=====================================\n")
	
	for key, info := range gt.functions {
		avgGas := info.Consumed
		if info.CallCount > 1 {
			avgGas = info.Consumed / int64(info.CallCount)
		}
		sb.WriteString(fmt.Sprintf("%-50s: %10d gas (calls: %d, avg: %d)\n", 
			key, info.Consumed, info.CallCount, avgGas))
	}
	
	return sb.String()
}

// Reset clears all tracked data
func (gt *GasTracker) Reset() {
	if !gt.enabled {
		return
	}
	gt.functions = make(map[string]*FunctionGasInfo)
	gt.callStack = make([]string, 0)
}
