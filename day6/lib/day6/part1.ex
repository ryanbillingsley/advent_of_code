defmodule Day6.Part1 do
  # Only need to report lit lights, but must toggle lights, which could still mean
  # only keeping a set of lights that are on.  This could also be a good use case
  # for an Agent
  # Keep a set of on and off lights.  Set can do fast finding for a member.


  def start do
    input = File.read!("input.txt")
            |> String.split(~r{\n})
            |> Enum.filter(&(&1 != ""))

    process(input)
  end

  def process(lines) do
    lines
    |> Enum.map(&parse_instruction/1)
    |> run_instructions(HashSet.new)
    |> Set.size
  end

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

  def run_instructions([], results), do: results
  def run_instructions([[instruction,lower,upper]|rest], results) do
    range = calculate_range(lower, upper) # list of ranges
    updated_results = range
                      |> execute_command(instruction, results)
    run_instructions(rest, updated_results)
  end

  def execute_command([], _instruction, on_lights), do: on_lights
  def execute_command([coord|rest], :toggle, on_lights) do
    case Set.member?(on_lights, coord) do
      true -> execute_command(rest, :toggle, Set.delete(on_lights,coord))
      false -> execute_command(rest, :toggle, Set.put(on_lights,coord))
    end
  end

  def execute_command([coord|rest], :on, on_lights) do
    case Set.member?(on_lights, coord) do
      true -> execute_command(rest, :on, on_lights)
      false -> execute_command(rest, :on, Set.put(on_lights,coord))
    end
  end

  def execute_command([coord|rest], :off, on_lights) do
    case Set.member?(on_lights, coord) do
      true -> execute_command(rest, :off, Set.delete(on_lights,coord))
      false -> execute_command(rest, :off, on_lights)
    end
  end

  def calculate_range({lower_x, lower_y}, {upper_x, upper_y}) do
    Enum.map(lower_y..upper_y, fn(row) ->
      Enum.zip(lower_x..upper_x, List.duplicate(row, ((upper_x + 1) - lower_x)))
    end)
    |> List.flatten
  end
end
