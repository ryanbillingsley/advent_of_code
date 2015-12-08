defmodule Day7.Part1Test do
  use ExUnit.Case
  doctest Day7.Part1
  alias Day7.Part1

  test "process instructions" do
    expect = Enum.into [{"f", 0}, {"d", 0}, {"c", -1}], HashDict.new
    result = Part1.start("test/test_input.txt")
    assert expect == result
  end
end
