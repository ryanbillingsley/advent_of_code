defmodule Day2.Part1 do
  def start() do
    input = File.read!("input.txt")
    |> String.split(~r{\n})

    Enum.reduce input, 0, &calculate_square_foot/2
  end

  def calculate_square_foot("", acc), do: acc
  def calculate_square_foot(dimension, acc) do
    new_area = dimension
    |> String.split("x")
    |> Enum.map(fn(x) ->
      {result, _} = Integer.parse(x)
      result
    end)
    |> calculate_area

    acc + new_area
  end

  def calculate_area([w,h,l] = dimension) do
    total_area = (2 * w * h) + (2 * w * l) + (2 * h * l)
    total_area + calculate_smallest_area(dimension)
  end

  def calculate_smallest_area([_w,_h,_l] = dimension) do
    [low, high] = dimension
    |> Enum.sort(&(&1 < &2))
    |> Enum.take(2)

    low * high
  end
end
