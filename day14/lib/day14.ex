defmodule Day14 do
  def parse(line) do
    [_all, name, speed, speed_duration, rest_duration] =
      Regex.run(~r/^(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds./,line)
    %{ name: name,
      speed: _convert_to_int(speed),
      speed_duration: _convert_to_int(speed_duration),
      rest_duration: _convert_to_int(rest_duration) }
  end

  defp _convert_to_int(string) do
    {int, _} = Integer.parse(string)
    int
  end
end
