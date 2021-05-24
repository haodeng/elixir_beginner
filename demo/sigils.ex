# The most common sigil in Elixir is ~r, which is used to create regular expressions
regex = ~r/foo|bar/
IO.puts("foo" =~ regex) # true
IO.puts("bat" =~ regex) # false

IO.puts("HELLO" =~ ~r/hello/) # false
# the i modifier makes a regular expression case insensitive
IO.puts("HELLO" =~ ~r/hello/i) # true

# sigils support 8 different delimiters
# The reason behind supporting different delimiters is to provide a way to write literals without escaped delimiters.
IO.puts("hello" =~ ~r/hello/)
IO.puts("hello" =~ ~r|hello|)
IO.puts("hello" =~ ~r"hello")
IO.puts("hello" =~ ~r'hello')
IO.puts("hello" =~ ~r(hello))
IO.puts("hello" =~ ~r[hello])
IO.puts("hello" =~ ~r{hello})
IO.puts("hello" =~ ~r<hello>)

# Strings
# The ~s sigil is used to generate strings, like double quotes are.
# The ~s sigil is useful when a string contains double quotes
IO.puts(~s(this is a string with "double" quotes, not 'single' ones)) # "this is a string with \"double\" quotes, not 'single' ones"

# Char lists
# The ~c sigil is useful for generating char lists that contain single quotes
IO.puts(~c(this is a char list containing 'single quotes')) # 'this is a char list containing \'single quotes\''

# Word lists
# Inside the ~w sigil, words are separated by whitespace.
IO.inspect(~w(foo bar bat)) # ["foo", "bar", "bat"]
# The ~w sigil also accepts the c, s and a modifiers (for char lists, strings, and atoms, respectively)
IO.inspect(~w(foo bar bat)a) # [:foo, :bar, :bat]

# both ~s and ~S will return strings, the former allows escape codes and interpolation while the latter does not
IO.puts(~s(String with escape codes \x26 #{"inter" <> "polation"})) # String with escape codes & interpolation
IO.puts(~S(String without escape codes \x26 without #{interpolation})) # String without escape codes \x26 without #{interpolation}

# date
d = ~D[2019-10-31]
IO.puts(d.day) # 31

# time
t = ~T[23:00:07.0]
IO.puts(t.second) # 7

# NaiveDateTime, Why is it called naive? Because it does not contain timezone information.
ndt = ~N[2019-10-31 23:00:07]
IO.puts(ndt.year)  # 2019

# UTC DateTime
dt = ~U[2019-10-31 19:59:03Z]
%DateTime{minute: minute, time_zone: time_zone} = dt
IO.puts(minute) # 59
IO.puts(time_zone) # "Etc/UTC"

