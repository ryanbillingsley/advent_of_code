defmodule Day3.Part2 do
  import Day3

  def start() do
    input = File.read!("input.txt")
            |> String.split(~r{})
            |> Enum.filter(&(&1 != ""))

    process(input)
  end

  def process(input) do
    {santa, bot} = split_input input

    IO.inspect Enum.take(santa, 10)
    IO.inspect Enum.take(bot, 10)

    santa_results = Enum.uniq move(santa,[%{x: 0, y: 0}])
    bot_results = Enum.uniq move(bot, [%{x: 0, y: 0}])

    results = Enum.concat(santa_results, bot_results)
              |> Enum.uniq
              |> Enum.count

    results
  end

  def split_input(input) do
    list1 = input
            |> Enum.take_every(2)

    list2 = input
            |> Enum.drop(1)
            |> Enum.take_every(2)

    {list1, list2}
  end
end
