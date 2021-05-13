#  elixir basic_types.ex
IO.inspect(1)
IO.inspect(0x1F) # integer
IO.inspect(1.0)
IO.inspect(true)
IO.inspect(:atom)
IO.inspect("string")
IO.inspect([1, 2, 3])
IO.inspect({1, 2, 3})

IO.inspect(1 + 2)
IO.inspect(2 * 2)
# In Elixir, the operator / always returns a float.
IO.inspect(10 / 2) # 5.0

# integer division
IO.inspect(div(10 ,2)) # 5
IO.inspect(div 10 , 2)
IO.inspect(rem(10, 3))

IO.inspect(0b1010) # binary, 10
IO.inspect(0o777) # octal, 511
IO.inspect(0x1F) # hex, 31

# Float numbers require a dot followed by at least one digit, Floats in Elixir are 64-bit double precision
IO.inspect(1.000001111)
IO.inspect(1.0e-10)

IO.inspect(round(3.58)) # 4
IO.inspect(trunc(3.58)) # 3

IO.inspect(true)
IO.inspect(true == false) # false

# Atom
IO.inspect(:apple) # :apple
IO.inspect(:orange) # :orange
IO.inspect(:apple == :apple) # true
IO.inspect(:apple == :orange) # false
# The booleans true and false are also atoms
IO.inspect(true == :true) # true
IO.inspect(is_atom(false)) # true
IO.inspect(is_boolean(:false)) # false
# Alias are also Atoms
IO.inspect(is_atom(Hello)) # true

# encoded in UTF-8
IO.inspect("hellö")

string = :world
IO.inspect("hellö #{string}") # "hellö world"
# hello
# world, line break
IO.puts("hello\nworld")
# Strings in Elixir are represented internally by contiguous sequences of bytes known as binaries
IO.inspect(is_binary("hellö")) # true
# the grapheme “ö” takes 2 bytes to be represented in UTF-8.
IO.inspect(byte_size("hellö")) # 6
# get the actual length of the string
IO.inspect(String.length("hellö")) # 5
IO.inspect(String.upcase("hellö")) # "HELLÖ"

# Anonymous functions
add = fn a, b -> a + b end
IO.inspect(add.(1, 2)) # 3
IO.inspect(is_function(add)) # true

# define a new anonymous function that uses the add anonymous function we have previously defined:
double = fn a -> add.(a, a) end
IO.inspect(double.(2)) # 4

# (Linked) Lists, Values can be of any type
IO.inspect([1, 2, true, 3])
IO.inspect(length [1, 2, 3]) # 3
# concatenated
IO.inspect([1, 2, 3] ++ [4, 5, 6]) # [1, 2, 3, 4, 5, 6]
# subtracted
IO.inspect([1, true, 2, false, 3, true] -- [true, false]) # [1, 2, 3, true]
list = [1, 2, 3]
IO.inspect(hd(list)) # 1, head the 1st element
IO.inspect(tl(list)) # [2, 3]. tail, reminder of the list
# When Elixir sees a list of printable ASCII numbers, Elixir will print that as a charlist (literally a list of characters).
IO.inspect([11, 12, 13]) # '\v\f\r'
IO.inspect([104, 101, 108, 108, 111]) # 'hello'
# single-quoted and double-quoted representations are not equivalent in Elixir as they are represented by different types
IO.inspect('hello' == "hello") # false

# Tuples, tuples can hold any value
tuple = {:ok, "hello"}
IO.inspect(tuple)
IO.inspect(elem(tuple, 1)) # "hello"
IO.inspect(tuple_size(tuple)) # 2
# put_elem/3 returned a new tuple. The original tuple stored in the tuple variable was not modified.
IO.inspect(put_elem(tuple, 1, "world")) # {:ok, "world"}
IO.inspect(tuple) # {:ok, "hello"}