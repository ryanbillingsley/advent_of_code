defmodule Day6.Part2Test do
  use ExUnit.Case
  doctest Day6.Part2

  test "Runs instructions" do
    # turn on 2,3 through 2,4 - 2
    # turn off 2,2 through 2,3 - 1
    # turn off 2,2 through 2,3 - 0
    # toggle 2,3 through 2,5 - 6

    expect = 6

    result = Day6.Part2.start("./test/day6/test_input.txt")

    assert result == expect
  end

  test "Runs instructions 2" do
    expect = 1
    result = Day6.Part2.start("./test/day6/test_input2.txt")
    assert result == expect
  end

  test "Runs instructions 3" do
    expect = 2000000
    result = Day6.Part2.start("./test/day6/test_input3.txt")
    assert result == expect
  end
end
