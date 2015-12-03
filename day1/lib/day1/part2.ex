defmodule Day1.Part2.Counter do
  def reach_basement(_col, -1, current_index), do: current_index

  def reach_basement([head|tail], current_floor, current_index) do
    case head do
      "(" -> reach_basement(tail, current_floor + 1, current_index + 1)
      ")" -> reach_basement(tail, current_floor - 1, current_index + 1)
      _ -> reach_basement(tail, current_floor, current_index + 1)
    end
  end
end
