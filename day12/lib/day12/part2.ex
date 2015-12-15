defmodule Day12.Part2 do
  import Poison.Parser

  def start do
    File.read!("input.txt")
    |> parse!(keys: :atoms!)
    |> search(0)
  end

  def search([], acc), do: acc
  def search([head|tail], acc) do
    IO.puts "List"
    IO.inspect head
    IO.puts "\n"
    results = search(head, acc)
    search(tail, results)
  end

  def search(head, acc) when is_map(head) do
    IO.puts "Map (last)"
    IO.inspect head
    IO.puts "\n"
    if Enum.any?(head, fn({_key, subvalue}) -> subvalue == "red" end) do
      search([],acc)
    else
      results = Enum.reduce(head, acc, &search/2)
      search([], results)
    end
  end

  def search({key, value}, acc) when is_number(value) do
    IO.puts "Tuple with number"
    IO.inspect key
    IO.puts "\n"
    search([], acc + value)
  end
  def search({key, value}, acc) do
    IO.puts "Tuple without"
    IO.inspect key
    IO.puts "\n"
    search(value, acc)
  end

  def search(value, acc) when is_number(value), do: search([], acc+value)
  def search(value, acc) when is_atom(value) do
    IO.puts "Atom"
    IO.inspect value
    IO.puts "\n"

    search([],acc)
  end
  def search(value, acc) when is_binary(value) do
    IO.puts "Binary"
    IO.inspect value
    IO.puts "\n"

    search([],acc)
  end
end
