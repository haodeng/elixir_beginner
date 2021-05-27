# ** (ArithmeticError) bad argument in arithmetic expression
#:foo + 1

# ** (RuntimeError) oops
#raise "oops"

# define your own errors by creating a module and using the defexception construct inside it
defmodule MyError do
  defexception message: "default message"
end

# ** (MyError) default message
# raise MyError

# ** (MyError) custom message
#raise MyError, message: "custom message"

# Errors can be rescued using the try/rescue construct
result = try do
  raise "oops"
rescue
    e in RuntimeError -> e
end
IO.inspect(result) # %RuntimeError{message: "oops"}

# If you don’t have any use for the error, you don’t have to provide it
result = try do
  raise "oops"
rescue
  RuntimeError -> "Error!"
end
IO.inspect(result) # "Error!"

# In practice, however, Elixir developers rarely use the try/rescue construct.
# File.read/1 function which returns a tuple containing information about whether the file was opened successfully
# There is no try/rescue here.
file = File.read("hello")
IO.inspect(file) # {:error, :enoent}
IO.inspect(File.write("hello", "world")) # :ok
IO.inspect(File.read("hello")) # {:ok, "world"}

# In case you want to handle multiple outcomes of opening a file, you can use pattern matching within the case construct:
case File.read("hello") do
  {:ok, body} -> IO.puts("Success: #{body}")
  {:error, reason} -> IO.puts("Error: #{reason}")
end
# Success: world

# For the cases where you do expect a file to exist (and the lack of that file is truly an error) you may use File.read!/1:
# File.read!("unknown") # ** (File.Error) could not read file "unknown": no such file or directory

# In Elixir, a value can be thrown and later be caught.
# Those situations are quite uncommon in practice except when interfacing with libraries that do not provide a proper API.
result = try do
  Enum.each(-50..50, fn(x) -> if rem(x, 13) == 0, do: throw(x) end)
    "Got nothing"
catch
  x -> "Got #{x}"
end
IO.puts(result) # Got -39

# ** (EXIT from #PID<0.94.0>) 1
#spawn_link(fn -> exit(1) end)

{:ok, file} = File.open("sample", [:utf8, :write])
result = try do
  IO.write(file, "olá")
  #raise "oops, something went wrong"
# The after clause will be executed regardless of whether or not the tried block succeeds.
after
  File.close(file)
end
IO.inspect(result) # ** (RuntimeError) oops, something went wrong

# Elixir allows you to omit the try line:
defmodule RunAfter do
  def without_even_trying do
      #raise "oops"
    after
      IO.puts "cleaning up!"
  end
end
RunAfter.without_even_trying # cleaning up!

# If an else block is present, it will match on the results of the try block whenever the try block finishes without a throw or an error
x = 2
result = try do
  1 / x
rescue
  ArithmeticError -> :infinity
else
  y when y < 1 and y > -1 -> :small
  _ -> :large
end
IO.puts(result) # small