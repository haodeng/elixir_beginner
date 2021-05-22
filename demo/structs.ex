# Structs are extensions built on top of maps that provide compile-time checks and default values.
defmodule User do
  defstruct name: "John", age: 27
end

# Structs take the name of the module they’re defined in.
# elixirc structs.ex
# iex
#iex> %User{}
#%User{age: 27, name: "John"}
#iex> %User{name: "Jon"}
#%User{age: 27, name: "Jon"}