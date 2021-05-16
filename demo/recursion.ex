# Due to immutability, loops in Elixir (as in any functional programming language)
# are written differently from imperative languages.
# data structures in Elixir are immutable. For this reason, functional languages rely on recursion:
# a function is called recursively until a condition is reached that stops the recursive action from continuing.
defmodule Recursion do

  # A particular clause is executed when the arguments passed to the function
  # match the clause’s argument patterns and its guards evaluate to true

  # use this definition if and only if n is less than or equal to 1
  def print_multiple_times(msg, n) when n <= 1 do
    IO.puts msg
  end

  def print_multiple_times(msg, n) do
    IO.puts msg
    print_multiple_times(msg, n - 1)
  end
end

Recursion.print_multiple_times("Hello!", 3)

defmodule Math do
  def sum_list([head | tail], accumulator) do
    sum_list(tail, head + accumulator)
  end

  # The process of taking a list and reducing it down to one value
  # is known as a reduce algorithm and is central to functional programming.
  def sum_list([], accumulator) do
    accumulator
  end

  def double_each([head | tail]) do
    [head * 2 | double_each(tail)]
  end

  # The process of taking a list and mapping over it is known as a map algorithm
  def double_each([]) do
    []
  end
end

IO.puts Math.sum_list([1, 2, 3], 0) #=> 6
IO.inspect Math.double_each([1, 2, 3]) #=> [2, 4, 6]

# The Enum module, which we’re going to see in the next chapter, already provides many conveniences for working with lists.
sum = Enum.reduce([1, 2, 3], 0, fn(x, acc) -> x + acc end)
IO.puts(sum) # 6
doubledList = Enum.map([1, 2, 3], fn(x) -> x * 2 end)
IO.inspect(doubledList) # [2, 4, 6]

# Or, using the capture syntax
sum = Enum.reduce([1, 2, 3], 0, &+/2)
IO.puts(sum) # 6
doubledList = Enum.map([1, 2, 3], &(&1 * 2))
IO.inspect(doubledList) # [2, 4, 6]