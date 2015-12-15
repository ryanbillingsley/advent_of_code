defmodule Day13.Part1 do
  require IEx
  def start(input) do
    influences = File.read!(input)
                 |> String.split(~r/\n/)
                 |> Enum.filter(&(&1 != ""))
                 |> Enum.map(&parse/1)

    Seatings.start_link influences

    people = influences
             |> Enum.uniq_by(&(&1.source))
             |> Enum.map(&(&1.source))
             |> permutations
             |> Enum.map(&add_first_to_last/1)

    people
    |> Enum.map(&(%{ path: &1, total: calculate_happiness(&1,0)}))
    |> Enum.max_by(&(&1.total))
  end

  def permutations([]), do: [[]]
  def permutations(list) do
    for h <- list, t <- permutations(list -- [h]), do: [h | t]
  end

  def add_first_to_last(list) do
    first = List.first list
    list ++ [first]
  end

  def parse(input) do
    [_whole,source,mod,value,target] = Regex.run(~r/(\w+) would (\w+) (\d+) happiness units by sitting next to (\w+).$/,input)
    {int, _} = Integer.parse(value)
    %{ source: source, mod: String.to_atom(mod), value: int, target: target }
  end


  def calculate_happiness([], acc), do: acc
  def calculate_happiness([source, target], acc) do
    _do_calculate(source, target, acc)
  end
  def calculate_happiness([source, target|rest], acc) do
    seating = Seatings.find_seating(source, target)
    calculate_happiness([target|rest], _do_calculate(seating.source,seating.target,acc))
  end

  defp _do_calculate(source, target, acc) do
    seating_front = Seatings.find_seating(source, target)
    result = modify(acc,seating_front)

    seating_back = Seatings.find_seating(target, source)
    modify(result,seating_back)
  end

  def modify(current, %{source: _source, mod: mod, value: value, target: _target }) when mod == :gain, do: current + value
  def modify(current, %{source: _source, mod: mod, value: value, target: _target }) when mod == :lose, do: current - value
end
