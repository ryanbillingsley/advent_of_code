defmodule Day14.Part1 do
  def start(input, runtime) do
    File.read!(input)
    |> String.split(~r/\n/)
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&parse/1)
    |> Enum.map(fn(deer) -> %{ name: deer.name, speed: calculate_distance(deer, runtime)} end)
    |> Enum.sort(&(&1.speed > &2.speed))
  end

  def parse(line) do
    [_all, name, speed, speed_duration, rest_duration] =
      Regex.run(~r/^(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds./,line)
    %{ name: name,
      speed: convert_to_int(speed),
      speed_duration: convert_to_int(speed_duration),
      rest_duration: convert_to_int(rest_duration) }
  end

  def convert_to_int(string) do
    {int, _} = Integer.parse(string)
    int
  end

  def calculate_distance(input, runtime) do
    total_duration = input.speed_duration + input.rest_duration
    segments = div(runtime, total_duration)
    rest = rem(runtime, total_duration)
    distance_covered = (input.speed * input.speed_duration)
    cond do
      rest >= input.speed_duration ->
        distance_covered * (segments + 1)
      rest < input.speed_duration ->
        distance_covered * segments
    end
  end
end
