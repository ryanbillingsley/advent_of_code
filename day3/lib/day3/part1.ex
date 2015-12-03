defmodule Day3.Part1 do
  import Day3

  def start() do
    input = File.read!("input.txt")
            |> String.split(~r{})
            |> Enum.filter(&(&1 != ""))

    results = process(input)
    IO.puts "Results: #{results}"
  end

  def process(input) do
    results = move(input,[%{x: 0, y: 0}])
              |> Enum.uniq
              |> Enum.count

    results
  end
end
