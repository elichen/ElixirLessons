defmodule Basics do
  def exercise1 do
    IO.puts "Hello world!"
  end
  
  def exercise2 do
    IO.puts "1. Add 5 and 3 = #{5+3}"
    IO.puts "2. Subtract 10 from 20 = #{20-10}"
    IO.puts "3. Multiply 4 by 5 = #{4*5}"
    IO.puts "4. Divide 20 by 5 = #{20/5}"
  end

  def exercise3 do
    numbers = [1, 2, 3, 4, 5]
    IO.puts "Sum: #{Enum.sum(numbers)}"
  end

  def exercise4 do
    name = "Alice"
    IO.puts "Hello #{name}"
  end

  def exercise5 do
    gen_greeting = fn (name) ->
      "hello #{name}!"
    end

    IO.puts gen_greeting.("Eli")
  end

  def exercise6 do
    person = {:ok, "John", 30}
    {:ok, name, age} = person
    IO.puts "Name: #{name}, Age: #{age}"
  end

  def exercise7 do
    even_or_odd = fn (n) ->
      if rem(n,2) == 0 do
        "Even"
      else
        "Odd"
      end
    end
    IO.puts even_or_odd.(20)
    IO.puts even_or_odd.(23)
  end
  
  def run do
    __MODULE__.__info__(:functions)
    |> Enum.filter(fn {name, _arity} -> String.starts_with?(Atom.to_string(name), "exercise") end)
    |> Enum.each(fn {name, _arity} ->
      apply(__MODULE__, name, [])
    end)
  end
end