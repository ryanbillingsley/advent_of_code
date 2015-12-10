defmodule Day10Test do
  use ExUnit.Case
  doctest Day10

  test "Turns 1 into 11" do
    expect = 6
    input = 1
    result = Day10.start input, 5

    assert expect == result
  end
end
