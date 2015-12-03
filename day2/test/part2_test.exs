defmodule Part2est do
  use ExUnit.Case, async: true
  require Day2.Part2

  test "Calculate ribbon needed for box" do
    input = [2,3,4]
    expect = 34

    actual = Day2.Part2.calculate_ribbon(input, 0)

    assert expect == actual
  end

  test "Santize dimensions" do
    input = "12x10x3"
    expect = [12,10,3]

    actual = Day2.Part2.sanitize_dimensions(input)

    assert expect == actual
  end
end
