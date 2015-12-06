defmodule Day5Test do
  use ExUnit.Case
  doctest Day5.Part1

  test "Parses ugknbfddgicrmopn" do
    input = "ugknbfddgicrmopn"

    assert Day5.Part1.parse_line(input) == true
  end

  test "Parses aaa" do
    input = "aaa"

    assert Day5.Part1.parse_line(input) == true
  end

  test "Parses jchzalrnumimnmhp as naughty" do
    input = "jchzalrnumimnmhp"

    assert Day5.Part1.parse_line(input) == false
  end

  test "Parses haegwjzuvuyypxyu as naughty" do
    input = "haegwjzuvuyypxyu"

    assert Day5.Part1.parse_line(input) == false
  end

  test "Parses dvszwmarrgswjxmb as naughty" do
    input = "dvszwmarrgswjxmb"

    assert Day5.Part1.parse_line(input) == false
  end

  test "Parses all lines" do
    inputs = [
      "ugknbfddgicrmopn",
      "aaa",
      "jchzalrnumimnmhp",
      "haegwjzuvuyypxyu",
      "dvszwmarrgswjxmb",
    ]

    expect = 2
    result = Day5.Part1.process(inputs)

    assert expect == result
  end
end
