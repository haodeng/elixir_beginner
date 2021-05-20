pid = spawn(fn -> 1 + 2 end)
IO.inspect(pid) # #PID<0.97.0>
# At this point, the process you spawned is very likely dead.
# The spawned process will execute the given function and exit after the function is done
IO.inspect(Process.alive?(pid)) # false

# retrieve the PID of the current process
IO.inspect(self()) # #PID<0.94.0>
IO.inspect(Process.alive?(self())) # true

# When a message is sent to a process, the message is stored in the process mailbox.
send(self(), {:hello, "world"})
# The receive/1 block goes through the current process mailbox
# searching for a message that matches any of the given patterns.
string = receive do
  {:hello, msg} -> msg
  {:world, _msg} -> "won't match"
end
IO.inspect(string) # "world"

# If there is no message in the mailbox matching any of the patterns,
# the current process will wait until a matching message arrives.
string = receive do
  {:hello, msg}  -> msg
# A timeout can also be specified
after
  1_000 -> "nothing after 1s"
end
IO.inspect(string) # "nothing after 1s"

parent = self()
spawn(fn -> send(parent, {:hello, self()}) end)
string = receive do
  {:hello, pid} -> "Got hello from #{inspect pid}"
end
IO.inspect(string) # "Got hello from #PID<0.98.0>"

# Tasks build on top of the spawn functions to provide better error reports and introspection:
Task.start(fn -> IO.puts "oops" end)

#  Elixir provides agents, which are simple abstractions around state:
{:ok, pid} = Agent.start_link(fn -> %{} end)
Agent.update(pid, fn map -> Map.put(map, :hello, :world) end)
result = Agent.get(pid, fn map -> Map.get(map, :hello) end)
IO.inspect(result) # :world