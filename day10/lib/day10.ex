defmodule Day10 do
  use Timex
  import ExProf.Macro
  def start(input, times) do
    profile do
      {time,final} = Time.measure(fn -> process_times(Integer.to_string(input), times) end)
      IO.puts("Result #{String.length(final)} Total Time: #{elapsed time}")
    end
  end

  def process_times(input, n) when n <= 1 do
    {time,result} = Time.measure(fn -> process(input) end)
    IO.puts "#{n} :: #{elapsed time}\n"
    result
  end

  def process_times(input, n) do
    {time,result} = Time.measure(fn -> process(input) end)
    IO.puts "#{n} :: #{elapsed time}\n"
    process_times(result, n - 1)
  end

  def process(input) do
    input
    |> String.codepoints
    |> count("")
  end

  def count([], acc), do: acc
  def count([number | _rest] = list, acc) do
    dups = Enum.take_while(list, &(&1 == number))
    count = Enum.count(dups)
    results = acc <> "#{Integer.to_string(count)}#{number}"
    count(Enum.drop(list,count), results)
  end

  defp elapsed(time) do
    TimeFormat.format(time, :humanized)
  end
end
