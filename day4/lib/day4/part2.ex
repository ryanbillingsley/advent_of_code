defmodule Day4.Part2 do
  def start() do
    input = "iwrupvqb"

    hash_away(input, 0)
  end

  def hash_away(input, num_try) do
    hash = :crypto.hash(:md5, "#{input}#{num_try}") |> Base.encode16
    case Regex.run(~r/^(0{6}.*)$/, hash)do
      nil -> hash_away(input, num_try + 1)
      [_full, result] -> IO.puts "Found result! #{num_try} #{result}"
    end
  end

end
