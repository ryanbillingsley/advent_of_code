defmodule Day3Test do
  use ExUnit.Case
  doctest Day3.Part1

  test "Move a single direction" do
    expect = 2
    actual = Day3.Part1.process(["^"])

    assert expect == actual
  end

  test "Move several directions" do
    expect = 4
    actual = Day3.Part1.process(["^",">","v","<"])

    assert expect == actual
  end

  test "Repeat directions several times" do
    expect = 2

    actual = Day3.Part1.process(["^","v","^","v","^","v","^","v","^","v"])

    assert expect == actual
  end
end
