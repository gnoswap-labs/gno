package expect

import "gno.land/p/demo/ufmt"

// Value creates a new checker values of different types.
func Value(t TestingT, value any) ValueChecker {
	return ValueChecker{
		ctx:   NewContext(t),
		value: value,
	}
}

// ValueChecker asserts values of different types.
type ValueChecker struct {
	ctx   Context
	value any
}

// WithFailPrefix assigns a prefix that will be prefixed to testing errors when an assertion fails.
func (c ValueChecker) WithFailPrefix(prefix string) ValueChecker {
	c.ctx.prefix = prefix
	return c
}

// Not negates the next called expectation.
func (c ValueChecker) Not() ValueChecker {
	c.ctx.negated = !c.ctx.negated
	return c
}

// ToBeNil asserts that current value is nil.
func (c ValueChecker) ToBeNil() {
	c.ctx.T().Helper()
	c.ctx.CheckExpectation(c.value == nil, func(ctx Context) string {
		if !ctx.IsNegated() {
			return ufmt.Sprintf("Expected value to be nil\nGot: %v", c.value)
		}
		return "Expected a non nil value"
	})
}

// ToEqual asserts that current value is equal to an expected value.
func (c ValueChecker) ToEqual(value any) {
	c.ctx.T().Helper()

	switch v := value.(type) {
	case string:
		c.AsString().ToEqual(v)
	case []byte:
		c.AsString().ToEqual(string(v))
	case bool:
		c.AsBoolean().ToEqual(v)
	case float32:
		c.AsFloat().ToEqual(float64(v))
	case float64:
		c.AsFloat().ToEqual(v)
	case uint:
		c.AsUint().ToEqual(uint64(v))
	case uint8:
		c.AsUint().ToEqual(uint64(v))
	case uint16:
		c.AsUint().ToEqual(uint64(v))
	case uint32:
		c.AsUint().ToEqual(uint64(v))
	case uint64:
		c.AsUint().ToEqual(v)
	case int:
		c.AsInt().ToEqual(int64(v))
	case int8:
		c.AsInt().ToEqual(int64(v))
	case int16:
		c.AsInt().ToEqual(int64(v))
	case int32:
		c.AsInt().ToEqual(int64(v))
	case int64:
		c.AsInt().ToEqual(v)
	default:
		c.ctx.Fail("Unsupported type: %T", value)
	}
}

// AsString returns a checker to assert current value as a string.
func (c ValueChecker) AsString() StringChecker {
	c.ctx.T().Helper()

	v, err := asString(c.value)
	if err != nil {
		c.ctx.Fail("Failed: %s: expected a string value\nGot: %T", err.Error(), c.value)
		return StringChecker{}
	}

	return NewStringChecker(c.ctx, v)
}

// AsBoolean returns a checker to assert current value as a boolean.
func (c ValueChecker) AsBoolean() BooleanChecker {
	c.ctx.T().Helper()

	v, err := asBoolean(c.value)
	if err != nil {
		c.ctx.Fail("Failed: %s: expected a boolean value\nGot: %T", err.Error(), c.value)
		return BooleanChecker{}
	}

	return NewBooleanChecker(c.ctx, v)
}

// AsFloat returns a checker to assert current value as a float64.
func (c ValueChecker) AsFloat() FloatChecker {
	c.ctx.T().Helper()

	v, err := asFloat(c.value)
	if err != nil {
		c.ctx.Fail("%s: expected a float value\nGot: %T", err.Error(), c.value)
		return FloatChecker{}
	}

	return NewFloatChecker(c.ctx, v)
}

// AsUint returns a checker to assert current value as a uint64.
func (c ValueChecker) AsUint() UintChecker {
	c.ctx.T().Helper()

	v, err := asUint(c.value)
	if err != nil {
		c.ctx.Fail("Failed: %s: expected a uint value\nGot: %T", err.Error(), c.value)
		return UintChecker{}
	}

	return NewUintChecker(c.ctx, v)
}

// AsInt returns a checker to assert current value as a int64.
func (c ValueChecker) AsInt() IntChecker {
	c.ctx.T().Helper()

	v, err := asInt(c.value)
	if err != nil {
		c.ctx.Fail("Failed: %s: expected an int value\nGot: %T", err.Error(), c.value)
		return IntChecker{}
	}

	return NewIntChecker(c.ctx, v)
}
