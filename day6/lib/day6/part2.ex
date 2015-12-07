defmodule Day6.Part2 do
  alias Day6.Brightness
  # Only need to report lit lights, but must toggle lights, which could still mean
  # only keeping a set of lights that are on.  This could also be a good use case
  # for an Agent
  # Keep a set of on and off lights.  Set can do fast finding for a member.


  def start(file \\ "input.txt") do
    Brightness.start_link
    File.stream!(file, [], :line)
    |> Enum.map(&String.strip/1)
    |> Enum.map(&parse_instruction/1)
    |> Enum.map(&run_instruction/1)

    count = Brightness.count

    IO.puts "Brightness at #{count}"
    count
  end

  ##
  # The failed async starter

  # def start(file \\ "input.txt") do
  #   Brightness.start_link
  #   File.stream!(file, [], :line)
  #   |> Enum.map(&String.strip/1)
  #   |> Enum.map(&parse_instruction/1)
  #   |> Enum.map(fn(instruction) ->
  #     Task.async(fn -> run_instruction(instruction) end)
  #   end)
  #   |> Enum.map(&Task.await(&1, (60000 * 5)))

  #   count = Brightness.count

  #   IO.puts "Brightness at #{count}"
  #   Brightness.stop
  #   count
  # end

  def parse_instruction(line) do
    parts = line
            |> String.split(" ")
            |> Enum.filter(&(&1 != ""))

    _parse_instruction(parts)
  end

  def _parse_instruction(["toggle",lower_range,"through",upper_range]) do
    [
      :toggle,
      convert_range_to_tuple(lower_range),
      convert_range_to_tuple(upper_range)
    ]
  end

  def _parse_instruction(["turn","on",lower_range,"through",upper_range]) do
    [
      :on,
      convert_range_to_tuple(lower_range),
      convert_range_to_tuple(upper_range)
    ]
  end

  def _parse_instruction(["turn","off",lower_range,"through",upper_range]) do
    [
      :off,
      convert_range_to_tuple(lower_range),
      convert_range_to_tuple(upper_range)
    ]
  end

  def convert_range_to_tuple(range_str) do
    [lower_str,upper_str] = range_str
    |> String.split(",")

    {lower, _} = Integer.parse(lower_str)
    {upper, _} = Integer.parse(upper_str)

    {lower,upper}
  end

  def run_instruction([instruction,lower,upper]) do
    IO.puts "Running instruction: #{instruction}"
    IO.inspect [lower,upper]

    calculate_range(lower, upper) # list of ranges
    |> execute_command(instruction)
    IO.puts "Finished execution"
  end

  # def run_instructions([], results), do: results
  # def run_instructions([[instruction,lower,upper]|rest], results) do
  #   range = calculate_range(lower, upper) # list of ranges
  #   updated_results = range
  #                     |> execute_command(instruction, results)
  #   run_instructions(rest, updated_results)
  # end

  def execute_command([], _instruction), do: :ok
  def execute_command([coord|rest], :toggle) do
    Brightness.add_brightness List.duplicate(coord,2)
    execute_command(rest, :toggle)
  end

  def execute_command([coord|rest], :on) do
    Brightness.add_brightness coord
    execute_command(rest, :on)
  end

  def execute_command([coord|rest], :off) do
    Brightness.remove_brightness coord
    execute_command(rest, :off)
  end

  # def execute_command([], _instruction, on_lights), do: on_lights
  # def execute_command([coord|rest], :toggle, on_lights) do
  #   new_results = Enum.concat(on_lights, List.duplicate([coord],2))
  #   execute_command(rest, :toggle, new_results)
  # end

  # def execute_command([coord|rest], :on, on_lights) do
  #   new_results = Enum.concat(on_lights, [coord])
  #   execute_command(rest, :on, new_results)
  # end

  # def execute_command([coord|rest], :off, on_lights) do
  #   new_results = List.delete(on_lights,coord)
  #   execute_command(rest, :off, new_results)
  # end

  def calculate_range({lower_x, lower_y}, {upper_x, upper_y}) do
    Enum.map(lower_y..upper_y, fn(row) ->
      Enum.zip(lower_x..upper_x, List.duplicate(row, ((upper_x + 1) - lower_x)))
    end)
    |> List.flatten
  end
end
