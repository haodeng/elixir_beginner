defmodule Math do
  def sum(a, b) do
    a + b
  end

  def sum2(a, b) do
    do_sum(a, b)
  end

  # private function
  defp do_sum(a, b) do
    a + b
  end

  # Function declarations also support guards and multiple clauses.
  # If a function has several clauses, Elixir will try each clause until it finds one that matches.
  def zero?(0) do
    true
  end

  def zero?(x) when is_integer(x) do
    false
  end
end

IO.puts(Math.sum(1, 2)) # 3
IO.puts(Math.sum2(1, 2)) # 3
# IO.puts(Math.do_sum(1, 2)) # ** (UndefinedFunctionError) function Math.do_sum/2 is undefined or private

IO.puts Math.zero?(0)         #=> true
IO.puts Math.zero?(1)         #=> false
#IO.puts Math.zero?([1, 2, 3]) #=> ** (FunctionClauseError) no function clause matching in Math.zero?/1
#IO.puts Math.zero?(0.0)       #=> ** (FunctionClauseError) no function clause matching in Math.zero?/1

# Function capturing
fun = &Math.zero?/1
IO.inspect(fun) # &Math.zero?/1
IO.inspect(is_function(fun)) # true
IO.inspect(fun.(0)) # true
IO.inspect(&is_function/1) # &:erlang.is_function/1
IO.inspect((&is_function/1).(fun)) # true, is_function(fun)

# the capture syntax can also be used as a shortcut for creating functions
# The &1 represents the first argument passed into the function.
fun = &(&1 + 1) # the same as: fn x -> x + 1 end
IO.inspect(fun.(1)) # 2
fun2 = &"Good #{&1}"
IO.inspect(fun2.("morning")) # "Good morning"

# Default arguments
defmodule Concat do
  # " " default value
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end

IO.puts Concat.join("Hello", "world")      #=> Hello world
IO.puts Concat.join("Hello", "world", "_") #=> Hello_world

# If a function with default values has multiple clauses,
# it is required to create a function head (a function definition without a body) for declaring defaults
defmodule Concat2 do
  # A function head declaring defaults
  def join(a, b \\ nil, sep \\ " ")

  # The leading underscore in _sep means that the variable will be ignored in this function
  def join(a, b, _sep) when is_nil(b) do
    a
  end

  def join(a, b, sep) do
    a <> sep <> b
  end
end

IO.puts Concat2.join("Hello", "world")      #=> Hello world
IO.puts Concat2.join("Hello", "world", "_") #=> Hello_world
IO.puts Concat2.join("Hello")               #=> Hello