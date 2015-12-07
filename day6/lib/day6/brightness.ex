defmodule Day6.Brightness do
  @name __MODULE__

  ##
  # External API

  def start_link, do: Agent.start_link(fn -> HashDict.new end, name: @name)
  def stop, do: Agent.stop(@name)

  def add_brightness([_head|_tail] = coords) do
    Agent.update(@name, &do_add_brightness(&1, coords))
  end

  def add_brightness({_x,_y} = coord) do
    Agent.update(@name, &add_one_brightness(coord, &1))
  end

  def remove_brightness({_x,_y} = coord) do
    Agent.update(@name, &do_remove_brightness(&1, coord))
  end

  def get_brightness, do: Agent.get(@name, &(&1))

  def count do
    Agent.get(@name, fn(dict) ->
      dict
      |> Dict.values
      |> Enum.sum
    end)
  end

  ##
  # Internal

  defp do_add_brightness(lights, coords) do
    Enum.reduce(coords, lights, &add_one_brightness(&1, &2))
  end

  defp add_one_brightness({x,y}, lights) do
    key = String.to_atom("x#{x}y#{y}")
    Dict.update(lights, key, 1, &(&1 + 1))
  end

  defp do_remove_brightness(lights, {x,y}) do
    key = String.to_atom("x#{x}y#{y}")
    Dict.update(lights, key, 0, fn(val) ->
      new_val = val - 1
      if new_val < 0 do
        new_val = 0
      end

      new_val
    end)
  end
end
