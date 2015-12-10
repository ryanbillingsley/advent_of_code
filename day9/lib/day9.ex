defmodule Day9 do
  alias Day9.Routes

  def start do
    input = File.read!("input.txt")
              |> String.split("\n")
              |> Enum.filter(&(&1 != ""))
              |> Enum.map(fn(path) ->
                [_str, departure, arrival, distance] = Regex.run(~r/^(\w+) to (\w+) = (\d+)$/,path)
                {int_distance, _ } = Integer.parse(distance)
                %{departure: departure, arrival: arrival, distance: int_distance}
              end)
    Routes.start_link(input)
    IO.inspect(Routes.contents)

    perms = input
             |> Enum.map(&([&1.arrival,&1.departure]))
             |> List.flatten
             |> Enum.uniq
             |> permutations
    IO.inspect(perms)

    perms
    |> Enum.map(&(%{ path: &1, total: calculate_distance(&1,0)}))
    # |> Enum.min_by(&(&1.total)) # Part 1
    |> Enum.max_by(&(&1.total)) # Part 2

  end

  def permutations([]), do: [[]]
  def permutations(list) do
    for h <- list, t <- permutations(list -- [h]), do: [h | t]
  end

  def calculate_distance([], acc), do: acc
  def calculate_distance([_end],acc), do: acc
  def calculate_distance([departure, arrival], acc) do
    route = Routes.find_route(departure, arrival)
    acc + route.distance
  end
  def calculate_distance([departure, arrival|rest], acc) do
    route = Routes.find_route(departure, arrival)
    calculate_distance([arrival|rest], acc + route.distance)
  end
end
