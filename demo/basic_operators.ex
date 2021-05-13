# ++ and -- to manipulate lists
IO.inspect([1, 2, 3] ++ [4, 5, 6]) # [1, 2, 3, 4, 5, 6]
IO.inspect([1, 2, 3] -- [2]) # [1, 3]

# String concatenation is done with <>
IO.inspect("foo" <> "bar") # "foobar"

# boolean operators: or, and and not
IO.inspect(true and true) # true
IO.inspect(false or is_atom(:example)) # true
# Providing a non-boolean will raise an exception
# ** (BadBooleanError) expected a boolean on left-side of "and", got: 1
# 1 and true

# ||, && and ! which accept arguments of any type.
# For these operators, all values except false and nil will evaluate to true
IO.inspect(1 || true) # 1
IO.inspect(false || 11) # 11
IO.inspect(nil && 13) # nil
IO.inspect(true && 17) # 17
IO.inspect(!true) # false
IO.inspect(!1) # false
IO.inspect(!nil) # true
# As a rule of thumb, use and, or and not when you are expecting booleans.
# If any of the arguments are non-boolean, use &&, || and !

# ==, !=, ===, !==, <=, >=, < and > as comparison operators
IO.inspect(1 == 1) # true
IO.inspect(1 === 1) # true
IO.inspect(1 != 2) # true
IO.inspect(1 < 2) # true
# The difference between == and === is that the latter is more strict when comparing integers and floats
IO.inspect(1 == 1.0) # true
IO.inspect(1 === 1.0) # false

# In Elixir, we can compare two different data types
# The overall sorting order is defined below:
# number < atom < reference < function < port < pid < tuple < map < list < bitstring
IO.inspect(1 < :atom) # true