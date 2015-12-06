defmodule Day5.Part2 do
  def start() do
    lines = File.read!("input.txt")
            |> String.split(~r{\n})
            |> Enum.filter(&(&1 != ""))

    IO.puts "Processing #{Enum.count(lines)} lines..."

    lines
    |> process
    |> Enum.count
  end

  def process(lines) do
    lines
    |> Enum.filter(&test/1)
  end

  def test(line) do
    duplicate? = line
                 |> char_pairs
                 |> find_duplicates

    repeat? = line
              |> split_word
              |> find_repeat

    duplicate? && repeat?
  end

  def char_pairs(string) do
    string
    |> String.split(~r{})
    |> Enum.filter(&(&1 != ""))
    |> Enum.chunk(2,1)
    |> Enum.filter(&(Enum.count(&1) == 2))
    |> Enum.map(fn([a,b]) -> a<>b end)
  end

  def split_word(string) do
    string
    |> String.split(~r{})
    |> Enum.filter(&(&1 != ""))
  end

  # This was the first implementation, but it always came up short,
  # and was heavily over-engineered which caused issues.
  #
  # The second iteration is so much simpler

  # def find_duplicates(pairs) do
  #   _find_duplicates(pairs, 0, false)
  # end

  # defp _find_duplicates([], _index, acc), do: acc
  # defp _find_duplicates([pair|rest], index, acc) do
  #   match? = rest
  #   |> Enum.with_index
  #   |> Enum.filter(fn({match,match_index}) ->
  #     match == pair && match_index >= (index + 1)
  #   end)
  #   |> List.first

  #   case match? do
  #     {_,_} -> _find_duplicates([], index, true)
  #     nil -> _find_duplicates(rest, index + 1, acc)
  #   end
  # end

  def find_duplicates(pairs) do
    _find_duplicates(pairs, false)
  end

  def _find_duplicates([], acc), do: acc
  def _find_duplicates([pair|rest], _acc) do
    possible = Enum.drop(rest, 1)
    case Enum.find(possible,&(&1 == pair)) do
      nil -> _find_duplicates(rest, false)
      _ -> _find_duplicates([], true)
    end
  end

  def find_repeat(list) do
    list
    |> Enum.chunk(3,1)
    |> Enum.any?(fn([char|_tail] = block) ->
      regex = Regex.compile!("#{char}\\w#{char}")
      Regex.match?(regex, Enum.join(block,""))
    end)
  end
end
