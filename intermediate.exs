defmodule Intermediate do
  def exercise1 do
    IO.puts "intermediate"
  end
  
  def run do
    __MODULE__.__info__(:functions)
    |> Enum.filter(fn {name, _arity} -> String.starts_with?(Atom.to_string(name), "exercise") end)
    |> Enum.each(fn {name, _arity} ->
      apply(__MODULE__, name, [])
    end)
  end
end
