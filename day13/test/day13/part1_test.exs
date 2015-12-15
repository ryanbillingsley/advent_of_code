defmodule Day13.Part1Test do
  use ExUnit.Case
  doctest Day13.Part1

  test "the truth" do
    expect = 330
    input = "test_input.txt"

    result = Day13.Part1.start(input)

    assert expect == result.total
  end
end
