
    iex> 1          # integer
    iex> 0x1F       # integer
    iex> 1.0        # float, Floats in Elixir are 64-bit double precision.
    iex> 1.0e-10    # also support e for scientific notation
    iex> true       # boolean
    iex> :atom      # atom / symbol
    iex> "elixir"   # string
    iex> [1, 2, 3]  # list
    iex> {1, 2, 3}  # tuple
    iex> 0b1010     # binary
    10
    iex> 0o777      # octal
    511
    iex> 0x1F       # hex
    31

# Basic arithmetic

    iex> 1 + 2
    3
    iex> 5 * 5
    25
    iex> 10 / 2.  # In Elixir, the operator / always returns a float.
    5.0

# Booleans

    iex> true
    true
    iex> true == false
    false
    
    # the is_boolean/1 function can be used to check if a value is a boolean or not
    iex> is_boolean(true)
    true
    iex> is_boolean(1)
    false
    
# Identifying functions and documentation
trunc/1 identifies the function which is named trunc and takes 1 argument, 
whereas trunc/2 identifies a different (nonexistent) function with the same name but with an arity of 2.

    iex> h trunc/1
                             def trunc()

    Returns the integer part of number.
