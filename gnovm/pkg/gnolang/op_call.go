package gnolang

import (
	"fmt"
	"reflect"
	"strings"
)

func (m *Machine) doOpPrecall() {
	cx := m.PopExpr().(*CallExpr)
	v := m.PeekValue(1 + cx.NumArgs).V
	if debug {
		if v == nil {
			// This may happen due to an undefined uverse or
			// closure value (which isn't supposed to happen but
			// may happen due to incomplete initialization).
			panic("should not happen")
		}
	}
	switch fv := v.(type) {
	case *FuncValue:
		m.PushFrameCall(cx, fv, TypedValue{})
		m.PushOp(OpCall)
	case *BoundMethodValue:
		m.PushFrameCall(cx, fv.Func, fv.Receiver)
		m.PushOp(OpCall)
	case TypeValue:
		// Do not pop type yet.
		// No need for frames.
		xv := m.PeekValue(1)
		if cx.GetAttribute(ATTR_SHIFT_RHS) == true {
			xv.AssertNonNegative("runtime error: negative shift amount")
		}

		m.PushOp(OpConvert)
		if debug {
			if len(cx.Args) != 1 {
				panic("conversion expressions only take 1 argument")
			}
		}
	default:
		panic(fmt.Sprintf(
			"unexpected function value type %s",
			reflect.TypeOf(v).String()))
	}
}

var gReturnStmt = &ReturnStmt{}

func (m *Machine) doOpCall() {
	// NOTE: Frame won't be popped until the statement is complete, to
	// discard the correct number of results for func calls in ExprStmts.
	fr := m.LastFrame()
	fv := fr.Func
	ft := fr.Func.GetType(m.Store)
	pts := ft.Params
	numParams := len(pts)
	isMethod := 0 // 1 if true
	// Create new block scope.
	clo := fr.Func.GetClosure(m.Store)
	b := m.Alloc.NewBlock(fr.Func.GetSource(m.Store), clo)

	// Copy *FuncValue.Captures into block
	// NOTE: addHeapCapture in preprocess ensures order.
	if len(fv.Captures) != 0 {
		if len(fv.Captures) > len(b.Values) {
			panic("should not happen, length of captured variables must not exceed the number of values")
		}
		for i := range fv.Captures {
			b.Values[len(b.Values)-len(fv.Captures)+i] = fv.Captures[i].Copy(m.Alloc)
		}
	}

	m.PushBlock(b)
	if fv.nativeBody == nil && fv.NativePkg != "" {
		// native function, unmarshaled so doesn't have nativeBody yet
		fv.nativeBody = m.Store.GetNative(fv.NativePkg, fv.NativeName)
		if fv.nativeBody == nil {
			panic(fmt.Sprintf("natively defined function (%q).%s could not be resolved", fv.NativePkg, fv.NativeName))
		}
	}
	if fv.nativeBody == nil {
		fbody := fv.GetBodyFromSource(m.Store)
		if len(ft.Results) == 0 {
			// Push final empty *ReturnStmt;
			// TODO: transform in preprocessor instead to return only
			// when necessary.
			// NOTE: m.PushOp(OpReturn) doesn't handle defers.
			m.PushStmt(gReturnStmt)
			m.PushOp(OpExec)
		} else {
			// Initialize return variables with default value.
			numParams := len(ft.Params)
			for i, rt := range ft.Results {
				// results/parameters never are heap use/closure.
				ptr := b.GetPointerToInt(nil, numParams+i)
				dtv := defaultTypedValue(m.Alloc, rt.Type)
				ptr.Assign2(m.Alloc, nil, nil, dtv, false)
			}
		}
		// Exec body.
		b.bodyStmt = bodyStmt{
			Body:          fbody,
			BodyLen:       len(fbody),
			NextBodyIndex: -2,
		}
		m.PushOp(OpBody)
		m.PushStmt(b.GetBodyStmt())
	} else {
		// No return exprs and no defers, safe to skip OpEval.
		// NOTE: m.PushOp(OpReturn) doesn't handle defers.
		m.PushOp(OpReturn)
		// Call native function.
		// It reads the native function from the frame,
		// so this op follows (this) OpCall.
		m.PushOp(OpCallNativeBody)
	}
	// Assign receiver as first parameter, if any.
	if !fr.Receiver.IsUndefined() {
		if debug {
			pt := pts[0].Type
			rt := fr.Receiver.T
			if pt.TypeID() != rt.TypeID() {
				panic(fmt.Sprintf(
					"expected %s but got %s",
					pt.String(),
					rt.String()))
			}
		}
		b.Values[0] = fr.Receiver
		isMethod = 1
	}
	// Convert variadic argument to slice argument.
	// TODO: more optimizations may be possible here if
	// varg is unescaping.
	// NOTE: this logic is somewhat duplicated for
	// doOpReturnCallDefers().
	if ft.HasVarg() {
		nvar := fr.NumArgs - (numParams - 1 - isMethod)
		if fr.IsVarg {
			// Do nothing, last arg type is already slice
			// type called with form fncall(?, vargs...)
			if debug {
				if nvar != 1 {
					panic("should not happen")
				}
			}
		} else {
			list := m.PopCopyValues(nvar)
			vart := pts[numParams-1].Type.(*SliceType)
			varg := m.Alloc.NewSliceFromList(list)
			m.PushValue(TypedValue{
				T: vart,
				V: varg,
			})
		}
	}
	// Assign non-receiver parameters in forward order.
	pvs := m.PopValues(numParams - isMethod)
	for i := isMethod; i < numParams; i++ {
		pv := pvs[i-isMethod]
		if debug {
			// This is how run-time untyped const
			// conversions would work, but we
			// expect the preprocessor to convert
			// these to *ConstExpr.
			/*
				// Convert if untyped const.
				if isUntyped(pv.T) {
					ConvertUntypedTo(&pv, pv.Type)
				}
			*/
			if isUntyped(pv.T) {
				panic("unexpected untyped const type for assign during runtime")
			}
		}
		// TODO: some more pt <> pv.Type
		// reconciliations/conversions necessary.

		// Make a copy so that a reference to the argument isn't used
		// in cases where the non-primitive value type is represented
		// as a pointer, *StructValue, for example.
		b.Values[i] = pv.Copy(m.Alloc)
	}
}

func (m *Machine) doOpCallNativeBody() {
	m.LastFrame().Func.nativeBody(m)
}

func (m *Machine) doOpCallDeferNativeBody() {
	fv := m.PopValue().V.(*FuncValue)
	fv.nativeBody(m)
}

// Assumes that result values are pushed onto the Values stack.
func (m *Machine) doOpReturn() {
	cfr := m.PopUntilLastCallFrame()
	// See if we are exiting a realm boundary.
	// NOTE: there are other ways to implement realm boundary transitions,
	// e.g. with independent Machine instances per realm for example, or
	// even only finalizing all realm transactions at the end of the
	// original statement execution, but for now we handle them like this,
	// per OpReturn*.
	crlm := m.Realm
	if crlm != nil {
		lrlm := cfr.LastRealm
		finalize := false
		if m.NumFrames() == 1 {
			// We are exiting the machine's realm.
			finalize = true
		} else if crlm != lrlm {
			// We are changing realms or exiting a realm.
			finalize = true
		}
		if finalize {
			// Finalize realm updates!
			// NOTE: This is a resource intensive undertaking.
			crlm.FinalizeRealmTransaction(m.Store)
		}
	}
	// finalize
	m.PopFrameAndReturn()
}

// Like doOpReturn, but with results from the block;
// i.e. named result vars declared in func signatures.
func (m *Machine) doOpReturnFromBlock() {
	// Copy results from block.
	cfr := m.PopUntilLastCallFrame()
	ft := cfr.Func.GetType(m.Store)
	numParams := len(ft.Params)
	numResults := len(ft.Results)
	fblock := m.Blocks[cfr.NumBlocks] // frame +1
	for i := range numResults {
		rtv := fillValueTV(m.Store, &fblock.Values[i+numParams])
		m.PushValue(*rtv)
	}
	// See if we are exiting a realm boundary.
	crlm := m.Realm
	if crlm != nil {
		lrlm := cfr.LastRealm
		finalize := false
		if m.NumFrames() == 1 {
			// We are exiting the machine's realm.
			finalize = true
		} else if crlm != lrlm {
			// We are changing realms or exiting a realm.
			finalize = true
		}
		if finalize {
			// Finalize realm updates!
			// NOTE: This is a resource intensive undertaking.
			crlm.FinalizeRealmTransaction(m.Store)
		}
	}
	// finalize
	m.PopFrameAndReturn()
}

// Before defers during return, move results to block so that
// deferred statements can refer to results with name
// expressions.
func (m *Machine) doOpReturnToBlock() {
	cfr := m.MustLastCallFrame(1)
	ft := cfr.Func.GetType(m.Store)
	numParams := len(ft.Params)
	numResults := len(ft.Results)
	fblock := m.Blocks[cfr.NumBlocks] // frame +1
	results := m.PopValues(numResults)
	for i := range numResults {
		rtv := results[i]
		fblock.Values[numParams+i] = rtv
	}
}

func (m *Machine) doOpReturnCallDefers() {
	cfr := m.MustLastCallFrame(1)
	dfr, ok := cfr.PopDefer()
	if !ok {
		// Done with defers.
		m.DeferPanicScope = 0
		m.ForcePopOp()
		if len(m.Exceptions) > 0 {
			// In a state of panic (not return).
			// Pop the containing function frame.
			m.PopFrame()
		}
		return
	}

	m.DeferPanicScope = dfr.PanicScope

	// Call last deferred call.
	// NOTE: the following logic is largely duplicated in doOpCall().
	// Convert if variadic argument.
	if dfr.Func != nil {
		fv := dfr.Func
		ft := fv.GetType(m.Store)
		pts := ft.Params
		numParams := len(ft.Params)
		// Create new block scope for defer.
		clo := dfr.Func.GetClosure(m.Store)
		b := m.Alloc.NewBlock(fv.GetSource(m.Store), clo)
		// copy values from captures
		if len(fv.Captures) != 0 {
			if len(fv.Captures) > len(b.Values) {
				panic("should not happen, length of captured variables must not exceed the number of values")
			}
			for i := range fv.Captures {
				b.Values[len(b.Values)-len(fv.Captures)+i] = fv.Captures[i].Copy(m.Alloc)
			}
		}
		m.PushBlock(b)
		if fv.nativeBody == nil {
			fbody := fv.GetBodyFromSource(m.Store)
			// Exec body.
			b.bodyStmt = bodyStmt{
				Body:          fbody,
				BodyLen:       len(fbody),
				NextBodyIndex: -2,
			}
			m.PushOp(OpBody)
			m.PushStmt(b.GetBodyStmt())
		} else {
			// Call native function.
			m.PushValue(TypedValue{
				T: ft,
				V: fv,
			})
			m.PushOp(OpCallDeferNativeBody)
		}
		if ft.HasVarg() {
			numArgs := len(dfr.Args)
			nvar := numArgs - (numParams - 1)
			if dfr.Source.Call.Varg {
				if debug {
					if nvar != 1 {
						panic("should not happen")
					}
				}
				// Do nothing, last arg type is already slice type
				// called with form fncall(?, vargs...)
			} else {
				// Convert last nvar to slice.
				vart := pts[len(pts)-1].Type.(*SliceType)
				baseArray := m.Alloc.NewListArray(nvar)
				vargs := baseArray.List
				copy(vargs, dfr.Args[numArgs-nvar:numArgs])
				varg := m.Alloc.NewSlice(baseArray, 0, nvar, nvar)
				dfr.Args = dfr.Args[:numArgs-nvar]
				dfr.Args = append(dfr.Args, TypedValue{
					T: vart,
					V: varg,
				})
			}
		}
		copy(b.Values, dfr.Args)
	} else {
		panic("should not happen")
	}
}

func (m *Machine) doOpDefer() {
	lb := m.LastBlock()
	cfr := m.MustLastCallFrame(1)
	ds := m.PopStmt().(*DeferStmt)
	// Pop arguments
	numArgs := len(ds.Call.Args)
	args := m.PopCopyValues(numArgs)
	// Pop func
	ftv := m.PopValue()
	// Push defer.
	switch cv := ftv.V.(type) {
	case *FuncValue:
		cfr.PushDefer(Defer{
			Func:       cv,
			Args:       args,
			Source:     ds,
			Parent:     lb,
			PanicScope: m.PanicScope,
		})
	case *BoundMethodValue:
		if debug {
			pt := cv.Func.GetType(m.Store).Params[0]
			rt := cv.Receiver.T
			if pt.TypeID() != rt.TypeID() {
				panic(fmt.Sprintf(
					"expected %s but got %s",
					pt.String(),
					rt.String()))
			}
		}
		args2 := make([]TypedValue, len(args)+1)
		args2[0] = cv.Receiver
		copy(args2[1:], args)
		cfr.PushDefer(Defer{
			Func:       cv.Func,
			Args:       args2,
			Source:     ds,
			Parent:     lb,
			PanicScope: m.PanicScope,
		})
	default:
		panic("should not happen")
	}
}

func (m *Machine) doOpPanic1() {
	// Pop exception
	var ex TypedValue = m.PopValue().Copy(m.Alloc)
	// Panic
	m.Panic(ex)
}

func (m *Machine) doOpPanic2() {
	if len(m.Exceptions) == 0 {
		// Recovered from panic
		m.PushOp(OpReturnFromBlock)
		m.PushOp(OpReturnCallDefers)
		m.PanicScope = 0
	} else {
		// Keep panicking
		last := m.PopUntilLastCallFrame()
		if last == nil {
			// Build exception string just as go, separated by \n\t.
			exs := make([]string, len(m.Exceptions))
			for i, ex := range m.Exceptions {
				exs[i] = ex.Sprint(m)
			}
			panic(UnhandledPanicError{
				Descriptor: strings.Join(exs, "\n\t"),
			})
		}
		m.PushOp(OpPanic2)
		m.PushOp(OpReturnCallDefers) // XXX rename, not return?
	}
}
