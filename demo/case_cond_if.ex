
# case allows us to compare a value against many patterns until we find a matching one
result = case {1, 2, 3} do
  {4, 5, 6} ->
    "This clause won't match"
  {1, x, 3} ->
    "This clause will match and bind x to 2 in this clause"
  _ ->
    "This clause would match any value"
end
IO.inspect(result) # "This clause will match and bind x to 2 in this clause"

# Clauses also allow extra conditions to be specified via guards
result = case {1, 2, 3} do
  # will only match when x is positive
  {1, x, 3} when x > 0 ->
    "Will match"
  _ ->
    "Would match, if guard condition were not satisfied"
end
IO.inspect(result) # "Will match"

# Keep in mind errors in guards do not leak but simply make the guard fail
#hd(1)
#** (ArgumentError) argument error
result = case 1 do
  # the error won't leak
  x when hd(x) -> "Won't match"
  x -> "Got #{x}"
end
IO.inspect(result) # "Got 1"

# If none of the clauses match, an error is raised
#case :ok do
  #:error -> "Won't match"
#end
#** (CaseClauseError) no case clause matching: :ok

# If you want to pattern match against an existing variable, you need to use the ^ operator
x = 1
result = case 10 do
  ^x -> "Won't match"
  _ -> "Will match"
end
IO.inspect(result) # "Will match"

# Note anonymous functions can also have multiple clauses and guards
f = fn
  x, y when x > 0 -> x + y
  x, y -> x * y
end
IO.inspect(f.(1, 3)) # 4
IO.inspect(f.(-1, 3)) # -3

# The number of arguments in each anonymous function clause needs to be the same, otherwise an error is raised
#f2 = fn
  #x, y when x > 0 -> x + y
  #x, y, z -> x * y + z
#end
#** (CompileError) iex:1: cannot mix clauses with different arities in anonymous functions

# in many circumstances, we want to check different conditions and find the first one that does not evaluate to nil or false.
# In such cases, one may use cond. This is equivalent to else if clauses in many imperative languages
result = cond do
  2 + 2 == 5 ->
      "This will not be true"
  2 * 2 == 3 ->
      "Nor this"
  1 + 1 == 2 ->
      "But this will"
end
IO.inspect(result) # "But this will"

# If all of the conditions return nil or false, an error (CondClauseError) is raised.
# For this reason, it may be necessary to add a final condition, equal to true, which will always match
result = cond do
  2 + 2 == 5 ->
      "This is never true"
  2 * 2 == 3 ->
      "Nor this"
  # a final condition
  true ->
      "This is always true (equivalent to else)"
end
IO.inspect(result) # "This is always true (equivalent to else)"

# note cond considers any value besides nil and false to be true
result = cond do
  hd([1, 2, 3]) ->
      "1 is considered as true"
end
IO.inspect(result) # "1 is considered as true"

# Elixir also provides the macros if/2 and unless/2 which are useful when you need to check for only one condition
result = if true do
  "This works!"
end
IO.inspect(result) #"This works!"

result = unless true do
  "This will never be seen"
end
IO.inspect(result) # nil

# If the condition given to if/2 returns false or nil, the body given between do/end is not executed and instead it returns nil.
# The opposite happens with unless/2
result = if false do
  "This works!"
end
IO.inspect(result) # nil

# They also support else blocks
result = if nil do
  "This won't be seen"
  else
  "This will"
end
IO.inspect(result) # "This will"

# If any variable is declared or changed inside if, case, and friends,
# the declaration and change will only be visible inside the construct.
x = 1
if true do
  x = x + 1
end
IO.inspect(x) # 1

# if you want to change a value, you must return the value from the if
x = 1
x = if true do
  x + 1
  else
  x
end
IO.inspect(x) # 2

# a comma between true and do:, that’s because it is using Elixir’s regular syntax where each argument is separated by a comma.
# We say this syntax is using keyword lists.
result = if true, do: 1 + 2
IO.inspect(result) # 3

result = if false, do: :this, else: :that
IO.inspect(result) # :that

# do/end blocks are a syntactic convenience built on top of the keyword ones.
# That’s why do/end blocks do not require a comma between the previous argument and the block.
# They are useful exactly because they remove the verbosity when writing blocks of code.
# These are equivalent
result = if true do
  a = 1 + 2
  a + 10
end
IO.inspect(result) # 13

result = if true, do: (
  a = 1 + 2
  a + 10
)
IO.inspect(result) # 13