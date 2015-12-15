defmodule Day14.Part2Test do
  use ExUnit.Case
  doctest Day14.Part2

  test "after 1 second, values match" do
    input = "test_input.txt"
    expect = %{"Dancer" => 1}
    result = Day14.Part2.start(input, 1)

    assert expect == result
  end

  test "after 140 seconds, values match" do
    input = "test_input.txt"
    expect = %{"Dancer" => 139, "Comet" => 1}
    result = Day14.Part2.start(input, 140)

    assert expect == result
  end

  test "after 1000 seconds, values match"  do
    input = "test_input.txt"
    expect = %{"Comet" => 312, "Dancer" => 689}
    result = Day14.Part2.start(input, 1000)

    assert expect == result
  end
end
