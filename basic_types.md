
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

# Atoms
An atom is a constant whose value is its own name. Some other languages call these symbols. They are often useful to enumerate over distinct values

    iex> :apple
    :apple
    iex> :orange
    :orange
    iex> :watermelon
    :watermelon
    
    iex> :apple == :apple
    true
    iex> :apple == :orange
    false
    
    # Elixir allows you to skip the leading : for the atoms false, true and nil.
    iex> true == :true
    true
    iex> is_atom(false)
    true
    iex> is_boolean(:false)
    true
    
    # Aliases start in upper case and are also atoms
    iex> is_atom(Hello)
    true
    
# String

    # Encoded in UTF-8
    iex> "hellö"
    "hellö"
    
    # string interpolation
    iex> string = :world
    iex> "hellö #{string}"
    "hellö world"
    
    # Line break
    iex> "hello
    ...> world"
    "hello\nworld"
    iex> "hello\nworld"
    "hello\nworld"
    
    # Print a string
    iex> IO.puts("hello\nworld")
    hello
    world
    :ok # IO.puts/1 function returns the atom :ok after printing.
    
    # Strings in Elixir are represented internally by contiguous sequences of bytes known as binaries
    iex> is_binary("hellö")
    true
    
    # the number of bytes in that string is 6, even though it has 5 graphemes. 
    # That’s because the grapheme “ö” takes 2 bytes to be represented in UTF-8. 
    iex> byte_size("hellö")
    6
    iex> String.length("hellö")
    5
    
    iex> String.upcase("hellö")
    "HELLÖ"
    
# Anonymous functions
a dot (.) between the variable and parentheses is required to invoke an anonymous function. 
The dot ensures there is no ambiguity between calling the anonymous function matched to a variable add and a named function add/2

    // The anonymous function is stored in the variable add
    iex> add = fn a, b -> a + b end
    #Function<12.71889879/2 in :erl_eval.expr/5>
    iex> add.(1, 2)
    3
    iex> is_function(add)
    true
    
Anonymous functions in Elixir are also identified by the number of arguments they receive. We can check if a function is of any given arity by using is_function/2:

    # check if add is a function that expects exactly 2 arguments
    iex> is_function(add, 2)
    true
    # check if add is a function that expects exactly 1 argument
    iex> is_function(add, 1)
    false
    
Let’s define a new anonymous function that uses the add anonymous function we have previously defined
    
    iex> double = fn a -> add.(a, a) end
    #Function<6.71889879/1 in :erl_eval.expr/5>
    iex> double.(2)
    4
    
 # (Linked) Lists
 
    # Values can be of any type
    iex> [1, 2, true, 3]
    [1, 2, true, 3]
    iex> length [1, 2, 3]
    3

Two lists can be concatenated or subtracted using the ++/2 and --/2 operators

    iex> [1, 2, 3] ++ [4, 5, 6]
    [1, 2, 3, 4, 5, 6]
    iex> [1, true, 2, false, 3, true] -- [true, false]
    [1, 2, 3, true]
    
    iex> list = [1, 2, 3]
    # The head is the first element of a list
    iex> hd(list)
    1
    # the tail is the remainder of the list
    iex> tl(list)
    [2, 3]
    # Getting the head or the tail of an empty list throws an error
    iex> hd([])
    ** (ArgumentError) argument error
    
When Elixir sees a list of printable ASCII numbers, Elixir will print that as a charlist (literally a list of characters). 

    iex> [11, 12, 13]
    '\v\f\r'
    iex> [104, 101, 108, 108, 111]
    'hello'
    
single-quoted and double-quoted representations are not equivalent in Elixir as they are represented by different types:
Single quotes are charlists, double quotes are strings. 

    iex> 'hello' == "hello"
    
# Tuples
 Like lists, tuples can hold any value
 
     iex> {:ok, "hello"}
    {:ok, "hello"}
    iex> tuple_size {:ok, "hello"}
    2
    false
    
Tuples store elements contiguously in memory. This means accessing a tuple element by index or getting the tuple size is a fast operation. 
Indexes start from zero

    iex> tuple = {:ok, "hello"}
    iex> elem(tuple, 1)
    "hello"
    iex> tuple_size(tuple)
    2

put_elem/3 returned a new tuple. The original tuple stored in the tuple variable was not modified. Like lists, tuples are also immutable. Every operation on a tuple returns a new tuple, it never changes the given one.

    iex> put_elem(tuple, 1, "world")
    {:ok, "world"}
    iex> tuple
    {:ok, "hello"}
