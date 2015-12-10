defmodule Day9.Routes do
  @name __MODULE__

  def start_link(input), do: Agent.start_link(fn -> input end, name: @name)
  def stop, do: Agent.stop(@name)

  def find_route(departure, arrival) do
    Agent.get(@name, fn(routes) ->
      routes
      |> Enum.find(&((&1.departure == departure and &1.arrival == arrival) or (&1.arrival == departure and &1.departure == arrival)))
    end)
  end

  def destinations_for_departure(departure) do
    Agent.get(@name, fn(routes) ->
      routes
      |> Enum.filter(&(&1.departure == departure))
    end)
  end

  def contents do
    Agent.get(@name, &(&1))
  end

  # defp _do_add_route(route, [] = _routes) do
  #   [%{ path: [route.departure, route.arrival], distance: route.distance }]
  # end
  # defp _do_add_route(route, [_|_] = routes) do
  #   updated = Enum.concat(routes, [%{ path: [route.departure, route.arrival], distance: route.distance }])

  #   Enum.filter(updated, fn(%{path: path}) ->
  #     List.last(path) == route.departure
  #   end)
  #   |> Enum.reduce(updated, fn(r, acc) ->
  #     new_route = %{path: Enum.concat(r.path, [route.arrival]), distance: r.distance + route.distance }
  #     new_list = List.delete acc, r
  #     Enum.concat(new_list, [new_route])
  #   end)
  # end
end
