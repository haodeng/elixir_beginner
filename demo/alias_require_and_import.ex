defmodule Hao do
  defmodule Deng do
    def test do
      IO.puts("Hao Deng")
    end
  end
end

defmodule AliasOne do
  alias Hao.Deng, as: Deng

  # Aliases are frequently used to define shortcuts. calling alias without an :as option
  # alias Hao.Deng

  # In the remaining module definition Deng expands to Hao.Deng.
  def test do
    IO.puts(Hao.Deng.test())
    IO.puts(Deng.test())
  end
end

AliasOne.test()

defmodule AliasTwo do
  # the alias will be valid only inside the function test. test2 won’t be affected at all
  def test do
    alias Hao.Deng
    IO.puts(Deng.test())
  end

  def test2 do
    # warning: Deng.test/0 is undefined (module Deng is not available or is yet to be defined)
    IO.puts(Deng.test())
  end
end

AliasTwo.test()

# An alias in Elixir is a capitalized identifier (like String, Keyword, etc) which is converted to an atom during compilation
IO.inspect(is_atom(String)) # true
IO.inspect(to_string(String)) # "Elixir.String"
IO.inspect(:"Elixir.String" == String) # true

# Aliases expand to atoms because in the Erlang VM (and consequently Elixir) modules are always represented by atoms
IO.inspect(List.flatten([1, [2], 3])) # [1, 2, 3]
IO.inspect(:"Elixir.List".flatten([1, [2], 3])) # [1, 2, 3]
# That’s the mechanism we use to call Erlang modules
IO.inspect(:lists.flatten([1, [2], 3])) # [1, 2, 3]

# In Elixir, Integer.is_odd/1 is defined as a macro
# you must require Integer before invoking the macro Integer.is_odd/1
require Integer
IO.inspect(Integer.is_odd(3)) # true

# Note that imports are generally discouraged in the language. When working on your own code, prefer alias to import.

# We imported only the function duplicate (with arity 2) from List. :except could also be given as an option
import List, only: [duplicate: 2]
IO.inspect(List.duplicate(:ok, 3)) # [:ok, :ok, :ok]
IO.inspect(duplicate(:ok, 3)) # [:ok, :ok, :ok]
# ** (CompileError) alias_require_and_import.ex:59: undefined function flatten/1
# flatten is not imported
# IO.inspect(flatten([1, [2], 3]))

defmodule Demo do
  # the imported List.duplicate/2 is only visible within that specific function.
  def some_function do
    import List, only: [duplicate: 2]
    IO.inspect duplicate(:ok, 10)
  end
end

Demo.some_function() # [:ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok, :ok]
