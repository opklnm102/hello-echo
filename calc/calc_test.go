package calc

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestAdd(t *testing.T) {
	n1 := 5
	n2 := 10

	assert.Equal(t, 15, add(n1, n2), "fail")
}

func TestSubtract(t *testing.T) {
	n1 := 5
	n2 := 10

	assert.Equal(t, -5, subtract(n1, n2), "fail")
}

func TestMultiple(t *testing.T) {
	n1 := 5
	n2 := 10

	assert.Equal(t, 50, multiple(n1, n2), "fail")
}
