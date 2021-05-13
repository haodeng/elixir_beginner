
IO.inspect(x = 1) # 1
# a valid expression, and it matched because both the left and right side are equal to 1.
IO.inspect(1 = x) # 1
#2 = x
#** (MatchError) no match of right hand side value: 1
# A variable can only be assigned on the left side of =
#1 = unknown
#** (CompileError) iex:1: undefined function unknown/0

{a, b, c} = {:hello, "world", 42}
IO.inspect(a) # :hello
IO.inspect(b) # "world"
IO.inspect(c) # 42

#{a, b, c} = {:hello, "world"}
#** (MatchError) no match of right hand side value: {:hello, "world"}

#{a, b, c} = [:hello, "world", 42]
#** (MatchError) no match of right hand side value: [:hello, "world", 42]

{:ok, result} = {:ok, 13}
IO.inspect(result) # 13
#{:ok, result} = {:error, :oops}
#** (MatchError) no match of right hand side value: {:error, :oops}

# We can pattern match on lists
[a, b, c] = [1, 2, 3]
IO.inspect(a) # 1
IO.inspect(b) # 2
IO.inspect(c) # 3

# A list also supports matching on its own head and tail
[head | tail] = [1, 2, 3]
IO.inspect(head) # 1
IO.inspect(tail) # [2, 3]

# The [head | tail] format is not only used on pattern matching but also for prepending items to a list
list = [1, 2, 3]
IO.inspect([0 | list]) # [0, 1, 2, 3]

x = 1
IO.inspect(x) # 1
# Variables in Elixir can be rebound
x = 2
IO.inspect(x) # 2
# Use the pin operator ^ when you want to pattern match against a variable’s existing value rather than rebinding the variable.
#^x = 2
#** (MatchError) no match of right hand side value: 2

x = 1
IO.inspect([^x, 2, 3] = [1, 2, 3]) # [1, 2, 3]
IO.inspect({y, ^x} = {2, 1}) # {1, 3}
# Because x was bound to the value of 1 when it was pinned
#{y, ^x} = {2, 2}
#** (MatchError) no match of right hand side value: {2, 2}

#  you don’t care about a particular value in a pattern. It is a common practice to bind those values to the underscore, _
# For example, if only the head of the list matters to us, we can assign the tail to underscore
[head | _] = [1, 2, 3]
IO.inspect(head) # 1
# The variable _ is special in that it can never be read from
#_
#** (CompileError) iex:1: invalid use of _. "_" represents a value to be ignored in a pattern and cannot be used in expressions
