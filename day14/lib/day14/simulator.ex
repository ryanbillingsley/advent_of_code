defmodule Day14.Simulator do
  @name __MODULE__

  ##
  # External

  def start_link, do: Agent.start_link(fn -> HashDict.new end, name: @name)
  def stop, do: Agent.stop(@name)

  def run_iteration(iteration, deer) do
    Agent.update(@name, &_do_add_iterations(&1, iteration, deer))
  end

  def determine_winner_for_iteration(iteration) do
    Agent.get(@name, fn(dict) ->
      Dict.fetch!(dict, Integer.to_string(iteration) |> String.to_atom)
      |> Enum.sort(&(&1.distance > &2.distance))
      |> List.first
    end)
  end

  def contents do
    Agent.get(@name, &(&1))
  end

  ##
  # Internal

  defp _do_add_iterations(iterations, iteration, deer) do
    deer
    |> Enum.reduce(iterations, &_do_add_iteration(&1, &2, iteration))
  end

  defp _do_add_iteration(deer, iterations, iteration) do
    IO.puts iteration
    total_dur = deer.speed_duration + deer.rest_duration

    cond do
      iteration <= deer.speed_duration ->
        entry = %{name: deer.name, distance: deer.speed }
      iteration > deer.speed_duration and iteration <= total_dur ->
        entry = %{name: deer.name, distance: 0 }
      div(iteration, total_dur) > 0 and rem(iteration, total_dur) == 0 ->
        entry = %{name: deer.name, distance: 0 }
      div(iteration, total_dur) > 0 and rem(iteration, total_dur) <= deer.speed_duration ->
        entry = %{name: deer.name, distance: deer.speed }
      div(iteration, total_dur) > 0 and rem(iteration, total_dur) > deer.speed_duration ->
        entry = %{name: deer.name, distance: 0 }
    end

    key = Integer.to_string(iteration) |> String.to_atom

    if iteration - 1 == 0 do
      Dict.update(iterations, key, [entry], fn(val) ->
        Enum.concat(val, [entry])
      end)
    else
      prev_key = Integer.to_string(iteration - 1) |> String.to_atom

      prev_iter = Dict.fetch!(iterations, prev_key)
      deer_iter = Enum.find(prev_iter, &(&1.name == deer.name))

      value = %{ name: entry.name, distance: deer_iter.distance + entry.distance }
      Dict.update(iterations, key, [value], fn(val) ->
        Enum.concat(val, [value])
      end)
    end
  end
end
