defmodule Math do
  @moduledoc """
  Provides math-related functions.

  ## Examples

    iex> Math.sum(1, 2)
    3

  """

  @doc """
  Calculates the sum of two numbers.
  """
  def sum(a, b), do: a + b
end

#$ elixirc math.ex
#$ iex
#iex> h Math # Access the docs for the module Math
#iex> h Math.sum # Access the docs for the sum function

defmodule MyServer do
  @initial_state %{host: "127.0.0.1", port: 3456}
  IO.inspect @initial_state

  # Trying to access an attribute that was not defined will print a warning
  # warning: undefined module attribute @unknown, please remove access to @unknown or explicitly set it before access
  @unknown

  @my_data 14
  def first_data, do: @my_data
  @my_data 13
  def second_data, do: @my_data
end

IO.puts MyServer.first_data() # 14
IO.puts MyServer.second_data() # 13

defmodule MyApp.Status do
  @service URI.parse("https://example.com")
  def status() do
    IO.inspect(@service)
  end
end

IO.inspect(MyApp.Status.status()) # %URI{authority: "example.com", fragment: nil, host: "example.com", path: nil, port: 443, query: nil, scheme: "https", userinfo: nil}

defmodule Foo do
  # configure the module attribute so that its values are accumulated
  Module.register_attribute __MODULE__, :param, accumulate: true

  @param :foo
  @param :bar
  # here @param == [:bar, :foo]

  def test do
    IO.inspect @param
  end
end

Foo.test() # [:bar, :foo]


