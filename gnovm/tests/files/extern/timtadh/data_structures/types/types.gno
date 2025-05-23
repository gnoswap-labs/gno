// from https://raw.githubusercontent.com/timtadh/data_structures/master/types/types.gno

package types

type Equatable interface {
	Equals(b Equatable) bool
}

type Sortable interface {
	Equatable
	Less(b Sortable) bool
}

type Hashable interface {
	Sortable
	Hash() int
}

type MHashable interface {
	Hashable
}

type (
	Iterator   func() (item any, next Iterator)
	KIterator  func() (key Hashable, next KIterator)
	KVIterator func() (key Hashable, value any, next KVIterator)
	Coroutine  func(send any) (recv any, next Coroutine)
)

type Iterable interface {
	Iterate() Iterator
}

type KIterable interface {
	Keys() KIterator
}

type VIterable interface {
	Values() Iterator
}

type KVIterable interface {
	Iterate() KVIterator
}

type MapIterable interface {
	KIterable
	VIterable
	KVIterable
}

type Sized interface {
	Size() int
}

type MapOperable interface {
	Sized
	Has(key Hashable) bool
	Put(key Hashable, value any) (err error)
	Get(key Hashable) (value any, err error)
	Remove(key Hashable) (value any, err error)
}

type WhereFunc func(value any) bool

type MultiMapOperable interface {
	Sized
	Has(key Hashable) bool
	Count(key Hashable) int
	Add(key Hashable, value any) (err error)
	Replace(key Hashable, where WhereFunc, value any) (err error)
	Find(key Hashable) KVIterator
	RemoveWhere(key Hashable, where WhereFunc) (err error)
}

type Map interface {
	MapIterable
	MapOperable
}

type MultiMap interface {
	MapIterable
	MultiMapOperable
}

type ContainerOperable interface {
	Has(item Hashable) bool
}

type ItemsOperable interface {
	Sized
	ContainerOperable
	Item(item Hashable) (Hashable, error)
	Add(item Hashable) (err error)
	Delete(item Hashable) (err error)
	Extend(items KIterator) (err error)
}

type OrderedOperable interface {
	Get(i int) (item Hashable, err error)
	Find(item Hashable) (idx int, has bool, err error)
}

type ListIterable interface {
	Items() KIterator
}

type IterableContainer interface {
	Sized
	ListIterable
	Has(item Hashable) bool
}

type StackOperable interface {
	Push(item Hashable) (err error)
	Pop() (item Hashable, err error)
}

type DequeOperable interface {
	EnqueFront(item Hashable) (err error)
	EnqueBack(item Hashable) (err error)
	DequeFront() (item Hashable, err error)
	DequeBack() (item Hashable, err error)
	First() (item Hashable)
	Last() (item Hashable)
}

type LinkedOperable interface {
	Sized
	ContainerOperable
	StackOperable
	DequeOperable
}

type ListOperable interface {
	Sized
	ContainerOperable
	Append(item Hashable) (err error)
	Get(i int) (item Hashable, err error)
	Set(i int, item Hashable) (err error)
	Insert(i int, item Hashable) (err error)
	Remove(i int) (err error)
}

type OrderedList interface {
	ListIterable
	OrderedOperable
}

type Set interface {
	Equatable
	ListIterable
	ItemsOperable
	Union(Set) (Set, error)
	Intersect(Set) (Set, error)
	Subtract(Set) (Set, error)
	Subset(Set) bool
	Superset(Set) bool
	ProperSubset(Set) bool
	ProperSuperset(Set) bool
}

type List interface {
	ListIterable
	ListOperable
}

type HList interface {
	Hashable
	List
}

type Stack interface {
	Sized
	ContainerOperable
	StackOperable
}

type Deque interface {
	Sized
	ContainerOperable
	DequeOperable
}

type Linked interface {
	LinkedOperable
	ListIterable
}

type Tree interface {
	Root() TreeNode
}

type TreeMap interface {
	Tree
	Map
}

type TreeNode interface {
	IsNil() bool
	Key() Hashable
	Value() any
	Children() TreeNodeIterator
	GetChild(int) TreeNode // if your tree can't support this simply panic
	// many of the utility functions do not require this
	// however, it is recommended that you implement it
	// if possible (for instance, post-order traversal
	// requires it).
	ChildCount() int // a negative value indicates this tree can't provide
	// an accurate count.
}
type TreeNodeIterator func() (node TreeNode, next TreeNodeIterator)

type BinaryTreeNode interface {
	TreeNode
	Left() BinaryTreeNode
	Right() BinaryTreeNode
}
