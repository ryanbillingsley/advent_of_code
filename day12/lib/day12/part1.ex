defmodule Day12.Part1 do
  def start do
    input = File.read!("input.txt")
    Regex.scan(~r/-?\d+/, input)
    |> List.flatten
    |> Enum.map(fn(str) ->
      {int, _} = Integer.parse(str)
      int
    end)
    |> Enum.sum
  end
end
