defmodule MyGenServer do
  use GenServer

  def init(_initial_state) do
    {:ok, %{count: 0}}
  end

  def handle_call(:current_counter, _from, state) do
    {:reply, state.count, state}
  end

  def handle_cast(:increment_counter, state) do
    new_state = Map.update!(state, :count, &(&1+1))
    {:noreply, new_state}
  end

  def handle_cast(:reset_counter, state) do
    new_state = Map.put(state, :count, 0)
    {:noreply, new_state}
  end
end

defmodule Intermediate do
  # Exercise 1: Recursion
  # Implement a function `factorial(n)` that calculates the factorial of `n` using recursion.
  def exercise1() do
    factorial = fn
      0, _rec -> 1
      n, rec -> n * rec.(n-1, rec)
    end
    IO.puts factorial.(5, factorial)
  end

  # Exercise 2: Processes and Message Passing
  # Create two processes: a sender and a receiver. The sender should send a message to the receiver, 
  # and the receiver should print the message. Use spawn and send.
  def exercise2 do
    receiver = fn ->
      receive do
        msg -> IO.puts "Received message: #{msg}"
      end
    end
    receiver_pid = spawn(receiver)
    sender = fn ->
      send(receiver_pid, "Hello from sender!")
    end
    spawn(sender)
  end

  # Exercise 3: Enum and Stream
  # Use the `Enum` module to filter even numbers from a list, square them, and then sum them up.
  # After that, try using `Stream` to lazily process a range of numbers in the same way.
  def exercise3 do
    1..10 |> Enum.filter(fn x -> rem(x,2) == 0 end) |> Enum.sum |> IO.puts
    1..10 |> Stream.filter(&rem(&1,2) == 0) |> Enum.sum |> IO.puts
  end

  # Exercise 4: Comprehensions
  # Write a list comprehension that takes a list of strings, converts each string to uppercase, 
  # and returns a new list with the modified strings.
  def exercise4 do
    foo = fn l ->
      for s <- l, do: String.upcase(s)
    end
    fruits = ["apple", "banana", "cherry", "date", "elderberry"]
    IO.inspect foo.(fruits)
  end

  # Exercise 5: OTP and GenServer
  # Implement a simple GenServer that maintains a counter. It should support incrementing the counter,
  # resetting it, and retrieving the current value.
  def exercise5 do
    GenServer.start_link(MyGenServer, %{}, name: MyGenServer)
    s1 = GenServer.call(MyGenServer, :current_counter)
    GenServer.cast(MyGenServer, :increment_counter)
    GenServer.cast(MyGenServer, :increment_counter)
    GenServer.cast(MyGenServer, :increment_counter)
    s2 = GenServer.call(MyGenServer, :current_counter)
    GenServer.cast(MyGenServer, :reset_counter)
    s3 = GenServer.call(MyGenServer, :current_counter)
    IO.puts "s1:#{s1} s2: #{s2} s3: #{s3}"
  end

  # Exercise 6: Supervisors and Application Structure
  # Create a simple application with a supervisor that starts and supervises the GenServer from Exercise 5.
  def exercise6 do
    # Your implementation here
  end

  # Exercise 7: Elixir's Tooling
  # This exercise is more about exploring outside the code. Use Mix to create a new project, 
  # and write unit tests for one of the functions above using ExUnit.
  # No code stub needed here, but explore and implement in a new Mix project.

  # Exercise 8: Working with Databases and Ecto
  # Define a simple Ecto schema for a "User" with fields: name (string) and age (integer).
  # Perform basic CRUD operations on the User schema. This will require setting up a project with Ecto.
  def exercise8 do
    # Your implementation here
  end
  
  def run do
    __MODULE__.__info__(:functions)
    |> Enum.filter(fn {name, _arity} -> String.starts_with?(Atom.to_string(name), "exercise") end)
    |> Enum.each(fn {name, _arity} ->
      apply(__MODULE__, name, [])
    end)
  end
end
