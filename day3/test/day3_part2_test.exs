defmodule Day3.Part2Test do
  use ExUnit.Case
  doctest Day3.Part2

  test "Split a list of inputs" do
    data = ["^","v",">","<"]
    expect_first = ["^",">"]
    expect_second = ["v","<"]

    {first, second} = Day3.Part2.split_input data

    assert expect_first == first
    assert expect_second == second
  end

  test "Process instructions with a small data set" do
    data = ["^","v"]
    expect = 3

    results = Day3.Part2.process(data)
    assert expect == results
  end

  test "Process instructions with a bigger data set" do
    data = ["^","v",">",">",">",">"]
    expect = 7

    results = Day3.Part2.process(data)
    assert expect == results
  end

  test "Process instructions with overlap" do
    data = ["^","^"]
    expect = 2

    results = Day3.Part2.process(data)
    assert expect == results
  end

  test "Process instructions with square" do
    data = ["^",">","v","<"]
    expect = 3

    results = Day3.Part2.process(data)
    assert expect == results
  end

  test "Process Instructions with alternating deliveries" do
    data = ["^","v","^","v","^","v","^","v","^","v"]
    expect = 11

    results = Day3.Part2.process(data)

    assert expect == results
  end

  test "Beginning of sequence" do
    input = "^^<<v<<v><v^^<"
    data = input
           |> String.split(~r{})
           |> Enum.filter(&(&1 != ""))

    expect = 10

    results = Day3.Part2.process(data)

    assert expect == results
  end
end
