defmodule Day2.Part2 do
  def start() do
    input = File.read!("input.txt")
    |> String.split(~r{\n})
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&sanitize_dimensions/1)

    Enum.reduce input, 0, &calculate_ribbon/2
  end

  def sanitize_dimensions(raw) do
      dimension = raw
      |> String.split("x")
      |> Enum.map(fn(x) ->
        {result, _} = Integer.parse(x)
        result
      end)
      dimension
  end

  def calculate_ribbon([w,h,l] = dimension, acc) do
    [low, high] = dimension
      |> Enum.sort(&(&1 < &2))
      |> Enum.take(2)

    ((2 * low) + (2 * high) + (w * h * l)) + acc
  end
end
