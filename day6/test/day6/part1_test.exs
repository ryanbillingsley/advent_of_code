defmodule Day6.Part1Test do
  use ExUnit.Case
  doctest Day6.Part1

  test "Calculates ranges" do
    #  1-2-3-4-5
    # 1_________
    # 2_________
    # 3__*_* * *
    # 4__*_* * *
    # 5__*_* * *

    expect = [
      {2,3}, {3,3}, {4,3}, {5,3},
      {2,4}, {3,4}, {4,4}, {5,4},
      {2,5}, {3,5}, {4,5}, {5,5}
    ]
    result = Day6.Part1.calculate_range({2,3},{5,5})

    assert expect == result
  end

  test "Parse range string" do
    expect = {5,2}
    input = "5,2"

    result = Day6.Part1.convert_range_to_tuple input

    assert expect == result
  end

  test "Parses instruction from line" do
    input = "toggle 461,550 through 564,900"
    expect = [:toggle, {461,550}, {564,900}]

    result = Day6.Part1.parse_instruction(input)

    assert expect == result

  end

  test "Runs instructions" do
    input = [
      [:on, {2,3}, {2,4}],
      [:off, {2,2}, {2,3}],
      [:toggle, {2,3}, {2,5}]
    ]

    expect = Enum.into [{2,3}], HashSet.new

    result = Day6.Part1.run_instructions(input, HashSet.new)
  end
end
