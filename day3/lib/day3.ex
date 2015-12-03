defmodule Day3 do
  def move([], deliveries), do: deliveries
  def move([head|_tail] = instructions, deliveries) when head == "^" do
    _move_with_direction(instructions, deliveries, 0, 1)
  end
  def move([head|_tail] = instructions, deliveries) when head == ">" do
    _move_with_direction(instructions, deliveries, 1, 0)
  end
  def move([head|_tail] = instructions, deliveries) when head == "v" do
    _move_with_direction(instructions, deliveries, 0, -1)
  end
  def move([head|_tail] = instructions, deliveries) when head == "<" do
    _move_with_direction(instructions, deliveries, -1, 0)
  end

  def _move_with_direction([_head|tail], deliveries, x_mod, y_mod) do
    last_delivery = List.last deliveries
    new_x = last_delivery.x + x_mod
    new_y = last_delivery.y + y_mod
    new_delivery = %{x: new_x, y: new_y}
    move(tail, Enum.concat(deliveries, [new_delivery]))
  end
end
