defmodule Day14.Part1Test do
  use ExUnit.Case
  doctest Day14.Part1

  test "after 1000 seconds, values match"  do
    input = "test_input.txt"
    expect = [%{name: "Comet", speed: 1120}, %{name: "Dancer", speed: 1056}]
    result = Day14.Part1.start(input, 1000)

    assert expect == result
  end
end
