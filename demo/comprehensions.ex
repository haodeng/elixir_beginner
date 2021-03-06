# Comprehensions are syntactic sugar for such constructs: they group those common tasks into the for special form


newList = for n <- [1, 2, 3, 4], do: n * n
IO.inspect(newList) # [1, 4, 9, 16]

# A comprehension is made of three parts: generators, filters, and collectables.
# n <- [1, 2, 3, 4] is the generator. It is literally generating values to be used in the comprehension.

# Any enumerable can be passed on the right-hand side of the generator expression
newList = for n <- 1..4, do: n * n
IO.inspect(newList) # [1, 4, 9, 16]

# Generator expressions also support pattern matching on their left-hand side;
# the key is the atom :good or :bad and we only want to compute the square of the :good values
values = [good: 1, good: 2, bad: 3, good: 4]
newList = for {:good, n} <- values, do: n * n
IO.inspect(newList) # [1, 4, 16]

# Alternatively to pattern matching, filters can be used to select some particular elements.
# Comprehensions discard all elements for which the filter expression returns false or nil; all other values are selected.
newList = for n <- 0..5, rem(n, 3) == 0, do: n * n
IO.inspect(newList) # [0, 9]

# comprehensions also allow multiple generators and filters to be given.
dirs = ['/Users/dev/tools', '/Users/dev/Music']
#  receives a list of directories and gets the size of each file in those directories:
newList = for dir <- dirs,
    file <- File.ls!(dir),
    path = Path.join(dir, file),
    File.regular?(path) do
  File.stat!(path).size
end
IO.inspect(newList) # [610489206, 8196, 998508624, 0]

# Multiple generators can also be used
# calculate the cartesian product of two lists:
newList = for i <- [:a, :b, :c], j <- [1, 2], do:  {i, j}
IO.inspect(newList) # [a: 1, a: 2, b: 1, b: 2, c: 1, c: 2]

# Bitstring generators
pixels = <<213, 45, 132, 64, 76, 32, 76, 0, 0, 234, 32, 15>>
rgb = for <<r::8, g::8, b::8 <- pixels>>, do: {r, g, b}
IO.inspect(rgb) # [{213, 45, 132}, {64, 76, 32}, {76, 0, 0}, {234, 32, 15}]

# :into accepts any structure that implements the Collectable protocol.
# the result of a comprehension can be inserted into different data structures by passing the :into option to the comprehension.
newString = for <<c <- " hello world ">>, c != ?\s, into: "", do: <<c>>
IO.inspect(newString) # "helloworld"

# A common use case of :into can be transforming values in a map
newMap = for {key, val} <- %{"a" => 1, "b" => 2}, into: %{}, do: {key, val * val}
IO.inspect(newMap) # %{"a" => 1, "b" => 4}

stream = IO.stream(:stdio, :line)
for line <- stream, into: stream do
  String.upcase(line) <> "\n"
end


