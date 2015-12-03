defmodule Part1Test do
  use ExUnit.Case, async: true
  require Day2.Part1

  test "Calculate smallest area returns the square feet" do
    input = [11,2,8]
    expect = 16

    actual = Day2.Part1.calculate_smallest_area(input)

    assert expect == actual
  end

  test "Calculate Area returns the square footage" do
    input = [11,2,8]
    expect = 268

    actual = Day2.Part1.calculate_area(input)

    assert expect == actual
  end

  test "Calculate square footage plus extra" do
    input = "11x2x8"
    expect = 268

    actual = Day2.Part1.calculate_square_foot(input, 0)

    assert expect == actual
  end
end
