defmodule Day14.Part2 do
  import Day14

  def start(input, runtime) do
    deer = File.read!(input)
           |> String.split(~r/\n/)
           |> Enum.filter(&(&1 != ""))
           |> Enum.map(&parse/1)

    run(Enum.into(1..runtime,[]),deer,%{})
    |> Enum.reduce(%{}, fn({_iter, distances}, acc) ->
      winner = Enum.max_by(distances, &(&1.distance))
      Map.update(acc, winner.name, 1, &(&1 + 1))
    end)
  end

  def run([], _deer, acc), do: acc
  def run([iter|rest], deer, acc) do
    key = Integer.to_string(iter) |> String.to_atom
    unless iter == 1 do
      prev_key = Integer.to_string(iter - 1) |> String.to_atom
      last = Map.fetch!(acc, prev_key)
      run(rest, deer, Map.put(acc, key, run_deer(deer, iter, last, [])))
    else
      run(rest, deer, Map.put(acc, key, run_deer(deer, iter, nil, [])))
    end
  end

  def run_deer([], _iter, _last, acc), do: acc
  def run_deer([deer|rest], iter, last, acc) when is_list(last) do
    last_entry = Enum.find(last, &(&1.name == deer.name))

    entry = _calc_distance(iter, deer, last_entry.distance)

    run_deer(rest, iter, last, Enum.concat(acc, [entry]))
  end
  def run_deer([deer|rest], iter, last, acc) do
    entry = _calc_distance(iter, deer, 0)
    run_deer(rest, iter, last, Enum.concat(acc, [entry]))
  end

  defp _calc_distance(iter, deer, prev) do
    total_dur = deer.speed_duration + deer.rest_duration
    cond do
      iter <= deer.speed_duration ->
        entry = %{name: deer.name, distance: deer.speed + prev }
      iter > deer.speed_duration and iter <= total_dur ->
        entry = %{name: deer.name, distance: 0 + prev}
      div(iter, total_dur) > 0 and rem(iter, total_dur) == 0 ->
        entry = %{name: deer.name, distance: 0 + prev }
      div(iter, total_dur) > 0 and rem(iter, total_dur) <= deer.speed_duration ->
        entry = %{name: deer.name, distance: deer.speed + prev }
      div(iter, total_dur) > 0 and rem(iter, total_dur) > deer.speed_duration ->
        entry = %{name: deer.name, distance: 0 + prev }
    end

    entry
  end
end
