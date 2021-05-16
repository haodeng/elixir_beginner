doubled = Enum.map([1, 2, 3], fn x -> x * 2 end)
IO.inspect(doubled) # [2, 4, 6]
kvs = Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k * v end)
IO.inspect(kvs) # [2, 12]

# Elixir also provides ranges
doubled = Enum.map(1..3, fn x -> x * 2 end)
IO.inspect(doubled) # [2, 4, 6]
sum = Enum.reduce(1..3, 0, &+/2)
IO.inspect(sum) # 6

# All the functions in the Enum module are eager.
odd? = &(rem(&1, 2) != 0)
IO.inspect(Enum.filter(1..3, odd?)) # [1, 3]

# This means that when performing multiple operations with Enum,
# each operation is going to generate an intermediate list until we reach the result

# We start with a range and then multiply each element in the range by 3.
# This first operation will now create and return a list with 100_000 items.
# Then we keep all odd elements from the list, generating a new list, now with 50_000 items,
# and then we sum all entries.
# The |> symbol is the pipe operator
oddSum = 1..100_000 |> Enum.map(&(&1 * 3)) |> Enum.filter(odd?) |> Enum.sum()
IO.puts(oddSum) # 7500000000

#  |> can make the code cleaner, have a look at the example above rewritten without using the |> operator
oddSumWithoutPipe = Enum.sum(Enum.filter(Enum.map(1..100_000, &(&1 * 3)), odd?))
IO.puts(oddSumWithoutPipe) # 7500000000

# As an alternative to Enum, Elixir provides the Stream module which supports lazy operations
# Instead of generating intermediate lists, streams build a series of computations that are invoked only when we pass the underlying stream to the Enum module.
# Streams are useful when working with large, possibly infinite, collections.
oddByStream = 1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) |> Enum.sum
IO.puts(oddByStream) # 7500000000

# Stream.cycle/1 can be used to create a stream that cycles a given enumerable infinitely.
# Be careful to not call a function like Enum.map/2 on such streams, as they would cycle forever
stream = Stream.cycle([1, 2, 3])
IO.inspect(Enum.take(stream, 10)) # [1, 2, 3, 1, 2, 3, 1, 2, 3, 1]

# Stream.unfold/2 can be used to generate values from a given initial value:
stream = Stream.unfold("hełło", &String.next_codepoint/1)
IO.inspect(Enum.take(stream, 3)) # ["h", "e", "ł"]