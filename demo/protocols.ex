# Protocols are a mechanism to achieve polymorphism in Elixir when you want behavior to vary depending on the data type.
defprotocol Utility do
  @spec type(t) :: String.t()
  def type(value)
end

defimpl Utility, for: BitString do
  def type(_value), do: "string"
end

defimpl Utility, for: Integer do
  def type(_value), do: "integer"
end

IO.puts(Utility.type("foo")) # "string"
IO.puts(Utility.type(123)) # "integer"

defprotocol Size do
  @doc "Calculates the size (and not the length!) of a data structure"
  def size(data)
end

defimpl Size, for: BitString do
  def size(string), do: byte_size(string)
end

defimpl Size, for: Map do
  def size(map), do: map_size(map)
end

defimpl Size, for: Tuple do
  def size(tuple), do: tuple_size(tuple)
end

IO.puts(Size.size("foo")) # 3
IO.puts(Size.size({:ok, "hello"})) # 2
IO.puts(Size.size(%{label: "some label"})) # 1
IO.puts(Size.size(%{})) # 0
# Size.size([1, 2, 3])  #** (Protocol.UndefinedError) protocol Size not implemented for [1, 2, 3]

# MapSet is a struct
set = %MapSet{} = MapSet.new
# Size.size(set) # ** (Protocol.UndefinedError) protocol Size not implemented for #MapSet<[]> of type MapSet (a struct)

# Instead of sharing protocol implementation with maps, structs require their own protocol implementation.
defimpl Size, for: MapSet do
  def size(set), do: MapSet.size(set)
end

IO.puts(Size.size(set)) # 0

# you could come up with your own semantics for the size of your struct.
defmodule User do
  defstruct [:name, :age]
end

defimpl Size, for: User do
  def size(_user), do: 2
end

# Enum module which provides many functions that work with any data structure that implements the Enumerable protocol
IO.inspect(Enum.map [1, 2, 3], fn(x) -> x * 2 end) # [2, 4, 6]
IO.inspect(Enum.reduce 1..3, 0, fn(x, acc) -> x + acc end) # 6

# String.Chars protocol exposed via the to_string function
IO.puts to_string :hello # "hello"
# Notice that string interpolation in Elixir calls the to_string function:
IO.puts("age: #{25}") # "age: 25"

# Passing a tuple, for example, will lead to an error:
tuple = {1, 2, 3}
# ** (Protocol.UndefinedError) protocol String.Chars not implemented for {1, 2, 3} of type Tuple
#"tuple: #{tuple}"

# When there is a need to “print” a more complex data structure,
# one can use the inspect function, based on the Inspect protocol
IO.puts "tuple: #{inspect tuple}" # tuple: {1, 2, 3}