string = "hello"
IO.inspect("hello")
IO.inspect(is_binary(string)) # true

# Unicode organizes all of the characters in its repertoire into code charts, and each character is given a unique numerical index.
# This numerical index is known as a Code Point
# in Elixir you can use a ? in front of a character literal to reveal its code point
IO.inspect(?a) # 97
IO.inspect(?ł)

# Note that most Unicode code charts will refer to a code point by its hexadecimal representation, e.g. 97 translates to 0061 in hex,
# and we can represent any Unicode character in an Elixir string by using the \u notation
# and the hex representation of its code point number
IO.inspect("\u0061" === "a") # true, 0061 hex = 97

# String.length/1 counts graphemes,
# but byte_size/1 reveals the number of underlying raw bytes needed to store the string when using UTF-8 encoding.
# UTF-8 requires one byte to represent the characters h, e, and o, but two bytes to represent ł
string = "hełło"
IO.inspect(String.length(string)) # 5
IO.inspect(byte_size(string)) # 7

# when you want to see the inner binary representation of a string is to concatenate the null byte <<0>> t
IO.inspect("hełło" <> <<0>>)  # <<104, 101, 197, 130, 197, 130, 111, 0>>
# Alternatively, you can view a string’s binary representation by using IO.inspect/2
IO.inspect("hełło", binaries: :as_binaries) # <<104, 101, 197, 130, 197, 130, 111>>

# Bitstrings
# denoted with the <<>> syntax. A bitstring is a contiguous sequence of bits in memory.
# By default, 8 bits (i.e. 1 byte) is used to store each number in a bitstring
IO.inspect(<<42>> === <<42::8>>) # true

# you can manually specify the number of bits via a ::n modifier to denote the size in n bits,
# or you can use the more verbose declaration ::size(n)
IO.inspect(<<3::4>>) # <<3::size(4)>>
IO.inspect(<<3::size(4)>>) # <<3::size(4)>>

# the decimal number 3 when represented with 4 bits in base 2 would be 0011,
# which is equivalent to the values 0, 0, 1, 1, each stored using 1 bi
IO.inspect(<<0::1, 0::1, 1::1, 1::1>> == <<3::4>>) # true

# Any value that exceeds what can be stored by the number of bits provisioned is truncated
# 257 in base 2 would be represented as 100000001, but since we have reserved only 8 bits for its representation (by default),
# the left-most bit is ignored and the value becomes truncated to 00000001, or simply 1 in decimal
IO.inspect(<<1>> === <<257>>) # true

# Binaries
# A binary is a bitstring where the number of bits is divisible by 8.
# That means that every binary is a bitstring, but not every bitstring is a binary.
IO.inspect(is_bitstring(<<3::4>>)) # true
IO.inspect(is_binary(<<3::4>>)) # false
IO.inspect(is_bitstring(<<0, 255, 42>>)) # true
IO.inspect(is_binary(<<0, 255, 42>>)) # true
IO.inspect(is_binary(<<42::16>>)) # true

# We can pattern match on binaries / bitstrings
<<0, 1, x>> = <<0, 1, 2>>
IO.inspect(x) # 2
# unless you explicitly use :: modifiers, each entry in the binary pattern is expected to match a single byte (exactly 8 bits).
# If we want to match on a binary of unknown size, we can use the binary modifier at the end of the pattern
<<0, 1, x::binary>> = <<0, 1, 2, 3>>
IO.inspect(x) # <<2, 3>>
# The binary-size(n) modifier will match n bytes in a binary
<<head::binary-size(2), rest::binary>> = <<0, 1, 2, 3>>
IO.inspect(head) # <<0, 1>>
IO.inspect(rest) # <<2, 3>>

# A string is a UTF-8 encoded binary, where the code point for each character is encoded using 1 to 4 bytes.
# Thus every string is a binary, but due to the UTF-8 standard encoding rules, not every binary is a valid string
IO.inspect(is_binary("hello")) # true
IO.inspect(is_binary(<<239, 191, 19>>)) # true
IO.inspect(String.valid?(<<239, 191, 19>>)) # false

# The string concatenation operator <> is actually a binary concatenation operator
IO.inspect("a" <> "ha") # "aha"
IO.inspect(<<0, 1>> <> <<2, 3>>) # <<0, 1, 2, 3>>

# Given that strings are binaries, we can also pattern match on string
<<head, rest::binary>> = "banana"
IO.inspect(head) # 98, "b"
IO.inspect(rest) # "anana"

# However, remember that binary pattern matching works on bytes,
# so matching on the string like “über” with multibyte characters won’t match on the character,
# it will match on the first byte of that character
IO.inspect("ü" <> <<0>>) # <<195, 188, 0>>
# x matched on only the first byte of the multibyte ü
<<x, rest::binary>> = "über"
IO.inspect(x == ?ü) # false
IO.inspect(x) # 195
IO.inspect(rest) # <<188, 98, 101, 114>>
# when pattern matching on strings, it is important to use the utf8 modifier
<<x::utf8, rest::binary>> = "über"
IO.inspect(x) # 252, ü
IO.inspect(x == ?ü) # true
IO.inspect(rest) # "ber"

# Charlists, A charlist is a list of integers where all the integers are valid code points.
# Whereas strings (i.e. binaries) are created using double-quotes, charlists are created with single-quoted literals
IO.inspect('hello') # 'hello'
IO.inspect([?h, ?e, ?l, ?l, ?o]) # 'hello'

#  instead of containing bytes, a charlist contains integer code points.
# However, the list is only printed in single-quotes if all code points are within the ASCII range:
IO.inspect('hełło') # [104, 101, 322, 322, 111]
IO.inspect(is_list('hełło')) # true

# You can convert a charlist to a string and back by using the to_string/1 and to_charlist/1
IO.inspect(to_charlist("hełło")) # [104, 101, 322, 322, 111]
IO.inspect(to_string('hełło')) # "hełło"
IO.inspect(to_string(:hello)) # "hello"
IO.inspect(to_string(1)) # "1"

# String (binary) concatenation uses the <> operator but charlists, being lists, use the list concatenation operator ++

#'this ' <> 'fails'
#** (ArgumentError) expected binary argument in <> operator but got: 'this '
#(elixir) lib/kernel.ex:1821: Kernel.wrap_concatenation/3
#(elixir) lib/kernel.ex:1808: Kernel.extract_concatenations/2
#(elixir) expanding macro: Kernel.<>/2
#iex:1: (file)

IO.inspect('this ' ++ 'works') # 'this works'

#"he" ++ "llo"
#** (ArgumentError) argument error
#:erlang.++("he", "llo")
IO.inspect("he" <> "llo") # "hello"

