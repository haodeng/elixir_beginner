# Keyword lists are important because they have three special characteristics:
# Keys must be atoms.
# Keys are ordered, as specified by the developer.
# Keys can be given more than once.

# In Elixir, when we have a list of tuples and the first item of the tuple (i.e. the key) is an atom, we call it a keyword list
list = [{:a, 1}, {:b, 2}]
IO.inspect(list) # [a: 1, b: 2]
IO.inspect(list == [a: 1, b: 2]) # true

# Since keyword lists are lists, we can use all operations available to lists.
IO.inspect(list ++ [c: 3]) # [a: 1, b: 2, c: 3]
IO.inspect([a: 0] ++ list) # [a: 0, a: 1, b: 2]

# values added to the front are the ones fetched on lookup
new_list = [a: 0] ++ list
IO.inspect(new_list) #[a: 0, a: 1, b: 2]
IO.inspect(new_list[:a]) # 0

# Maps
# Whenever you need a key-value store, maps are the “go to” data structure in Elixir
# Compared to keyword lists, we can already see two differences:
# Maps allow any value as a key.
# Maps’ keys do not follow any ordering.
map = %{:a => 1, 2 => :b}
IO.inspect(map) # %{2 => :b, :a => 1}
IO.inspect(map[:a]) # 1
IO.inspect(map[2]) # :b
IO.inspect(map[:c]) # nil

# pattern matching
%{} = %{:a => 1, 2 => :b}
%{:a => a} = %{:a => 1, 2 => :b}
IO.inspect(a) # 1
# a map matches as long as the keys in the pattern exist in the given map. Therefore, an empty map matches all maps.
#%{:c => c} = %{:a => 1, 2 => :b}
#** (MatchError) no match of right hand side value: %{2 => :b, :a => 1}

n = 1
map = %{n => :one}
IO.inspect(map) # {1 => :one}

IO.inspect(Map.get(%{:a => 1, 2 => :b}, :a)) #1
# add key/value
IO.inspect(Map.put(%{:a => 1, 2 => :b}, :c, 3)) # %{2 => :b, :a => 1, :c => 3}
# update value
IO.inspect(Map.put(%{:a => 1, 2 => :b}, :a, 3)) # %{2 => :b, :a => 3}
IO.inspect(Map.to_list(%{:a => 1, 2 => :b})) # [{2, :b}, {:a, 1}]

# updating a key’s value
map = %{:a => 1, 2 => :b}
new_map = %{map | 2 => "two"}
IO.inspect(new_map) # %{2 => "two", :a => 1}
# The syntax above requires the given key to exist.
# %{map | :c => 3}
#** (KeyError) key :c not found in: %{2 => :b, :a => 1}

# When all the keys in a map are atoms, you can use the keyword syntax for convenience:
map = %{a: 1, b: 2}
IO.inspect(map) # %{a: 1, b: 2}

# accessing atom keys, use the map.field syntax
map = %{:a => 1, 2 => :b}
IO.inspect(map.a) #1
# map.c
# ** (KeyError) key :c not found in: %{2 => :b, :a => 1}

# Nested data structures
# a keyword list of users where each value is a map containing the name, age and a list of programming languages each user likes.
users = [
  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]
# access the age for john
IO.inspect(users[:john].age) # 27
# we can also use this same syntax for updating the value:
users = put_in users[:john].age, 31
IO.inspect(users) # [
# john: %{age: 31, languages: ["Erlang", "Ruby", "Elixir"], name: "John"},
# mary: %{age: 29, languages: ["Elixir", "F#", "Clojure"], name: "Mary"}
# ]

# update_in/2 macro is similar but allows us to pass a function that controls how the value changes.
# remove “Clojure” from Mary’s list of languages
users = update_in users[:mary].languages, fn languages -> List.delete(languages, "Clojure") end
IO.inspect(users) # [
# john: %{age: 31, languages: ["Erlang", "Ruby", "Elixir"], name: "John"},
# mary: %{age: 29, languages: ["Elixir", "F#"], name: "Mary"}
# ]