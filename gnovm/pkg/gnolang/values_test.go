package gnolang

import (
	"fmt"
	"testing"
)

type mockTypedValueStruct struct {
	field int
}

func (m *mockTypedValueStruct) assertValue()          {}
func (m *mockTypedValueStruct) GetShallowSize() int64 { return 0 }
func (m *mockTypedValueStruct) VisitAssociated(vis Visitor) (stop bool) {
	return true
}

func (m *mockTypedValueStruct) String() string {
	return fmt.Sprintf("MockTypedValueStruct(%d)", m.field)
}

func (m *mockTypedValueStruct) DeepFill(store Store) Value {
	return m
}

// TestFileBlockMissingPanic tests the panic that occurs when a function's file block
// is missing from the package's fBlocksMap
func TestFileBlockMissingPanic(t *testing.T) {
	// Create a minimal store
	store := NewStore(nil, nil, nil)

	// Create a package value
	pv := &PackageValue{
		ObjectInfo: ObjectInfo{
			ID: ObjectID{
				PkgID: PkgID{},
			},
		},
		PkgName: "testpkg",
		PkgPath: "gno.land/r/test/testpkg",
		FNames:  []string{"file1.gno"}, // Note: file2.gno is missing
		FBlocks: []Value{&Block{}},
	}

	// Initialize fBlocksMap but don't add file2.gno
	pv.fBlocksMap = make(map[string]*Block)
	pv.fBlocksMap["file1.gno"] = &Block{}

	// Store the package
	store.SetCachePackage(pv)

	// Create a function that claims to be from file2.gno
	fv := &FuncValue{
		PkgPath:  "gno.land/r/test/testpkg",
		FileName: "file2.gno", // This file is not in fBlocksMap
		Parent:   nil,
		IsClosure: false,
	}

	// Test that GetParent panics with the expected message
	defer func() {
		if r := recover(); r != nil {
			expected := `file block missing for file "file2.gno"`
			if r != expected {
				t.Errorf("Expected panic message %q, got %q", expected, r)
			}
		} else {
			t.Error("Expected panic but didn't get one")
		}
	}()

	// This should panic
	fv.GetParent(store)
}

// TestFileBlockMissingWithInconsistentState tests a scenario where FNames/FBlocks
// arrays are inconsistent with fBlocksMap, simulating a package deployment issue
func TestFileBlockMissingWithInconsistentState(t *testing.T) {
	// Create a minimal store
	store := NewStore(nil, nil, nil)
	
	// Create a package value where a function exists but its file block is missing
	pv := &PackageValue{
		ObjectInfo: ObjectInfo{
			ID: ObjectID{
				PkgID: PkgID{},
			},
		},
		PkgName: "mypkg",
		PkgPath: "gno.land/r/test/mypkg",
		// FNames lists three files
		FNames:  []string{"main.gno", "types.gno", "utils.gno"},
		// But FBlocks only has two blocks (simulating deployment issue)
		FBlocks: []Value{&Block{}, &Block{}},
	}
	
	// deriveFBlocksMap would fail here because FNames and FBlocks lengths don't match
	// So we manually create an incomplete fBlocksMap
	pv.fBlocksMap = make(map[string]*Block)
	pv.fBlocksMap["main.gno"] = &Block{}
	pv.fBlocksMap["types.gno"] = &Block{}
	// utils.gno is missing from fBlocksMap
	
	// Store the package
	store.SetCachePackage(pv)

	// Create a function that's from the missing file
	fv := &FuncValue{
		PkgPath:  "gno.land/r/test/mypkg",
		FileName: "utils.gno", // This file is in FNames but not in fBlocksMap
		Parent:   nil,
		IsClosure: false,
		Name:     "HelperFunc",
	}

	// Test that GetParent panics with the expected message
	defer func() {
		if r := recover(); r != nil {
			expected := `file block missing for file "utils.gno"`
			if r != expected {
				t.Errorf("Expected panic message %q, got %q", expected, r)
			}
		} else {
			t.Error("Expected panic but didn't get one")
		}
	}()

	// This should panic
	fv.GetParent(store)
}

func TestGetLengthPanic(t *testing.T) {
	tests := []struct {
		name     string
		tv       TypedValue
		expected string
	}{
		{
			name: "NonArrayPointer",
			tv: TypedValue{
				T: &PointerType{Elt: &StructType{}},
				V: PointerValue{
					TV: &TypedValue{
						T: &StructType{},
						V: &mockTypedValueStruct{field: 42},
					},
				},
			},
			expected: "unexpected type for len(): *struct{}",
		},
		{
			name: "UnexpectedType",
			tv: TypedValue{
				T: &StructType{},
				V: &mockTypedValueStruct{field: 42},
			},
			expected: "unexpected type for len(): struct{}",
		},
		{
			name: "UnexpectedPointerType",
			tv: TypedValue{
				T: &PointerType{Elt: &StructType{}},
				V: nil,
			},
			expected: "unexpected type for len(): *struct{}",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			defer func() {
				if r := recover(); r == nil {
					t.Errorf("the code did not panic")
				} else {
					if r != tt.expected {
						t.Errorf("expected panic message to be %q, got %q", tt.expected, r)
					}
				}
			}()

			tt.tv.GetLength()
		})
	}
}
