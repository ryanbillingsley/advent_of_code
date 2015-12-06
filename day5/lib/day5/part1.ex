defmodule Day5.Part1 do
  def start() do
    input = File.read!("input.txt")
            |> String.split(~r{\n})
            |> Enum.filter(&(&1 != ""))

    process(input)
  end

  def process(lines) do
    good_lines = lines
                 |> Enum.map(&parse_line/1)
                 |> Enum.filter(&(&1))
                 |> Enum.count

    good_lines
  end

  def parse_line(line) do
    _double_letter?(line) && _vowels?(line) && _forbidden?(line)
  end

  defp _double_letter?(line) do
    Regex.match?(~r/(\w)\1+/,line)
  end

  defp _vowels?(line) do
    matches = Regex.scan(~r{[aeiou]},line)
    enough = matches
    |> List.flatten
    |> Enum.count >= 3
    enough
  end

  defp _forbidden?(line) do
    !Regex.match?(~r/ab|cd|pq|xy/,line)
  end

end
