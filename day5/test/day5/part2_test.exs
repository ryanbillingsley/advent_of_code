defmodule Day5.Part2Test do
  use ExUnit.Case
  doctest Day5.Part2

  test "Creates character pairs" do
    input = "qjhvhtzxzqqjkmpb"
    expect = [
      "qj",
      "jh",
      "hv",
      "vh",
      "ht",
      "tz",
      "zx",
      "xz",
      "zq",
      "qq",
      "qj",
      "jk",
      "km",
      "mp",
      "pb"]
    result = Day5.Part2.char_pairs(input)

    assert expect == result
  end

  test "Detects duplicates" do
    input = "qjhvhtzxzqqjkmpb"
    expect = true

    result = input
             |> Day5.Part2.char_pairs
             |> Day5.Part2.find_duplicates

    assert expect == result
  end

  test "Detect duplicate rule test 1"  do
    input = "xyxy"
    expect = true

    result = input
             |> Day5.Part2.char_pairs
             |> Day5.Part2.find_duplicates

    assert expect == result
  end

  test "Detect duplicate rule test 2"  do
    input = "aabcdefgaa"
    expect = true

    result = input
             |> Day5.Part2.char_pairs
             |> Day5.Part2.find_duplicates

    assert expect == result
  end

  test "Detect duplicate rule test 3"  do
    input = "aaghkdbcdefbcgaa"
    expect = true

    result = input
             |> Day5.Part2.char_pairs
             |> Day5.Part2.find_duplicates

    assert expect == result
  end

  test "Detects repeats 1" do
    input = "qjhvhtzxzqqjkmpb"
    expect = true

    result = input
             |> Day5.Part2.split_word
             |> Day5.Part2.find_repeat

    assert expect == result
  end

  test "Detects repeats 2" do
    input = "aaa"
    expect = true

    result = input
             |> Day5.Part2.split_word
             |> Day5.Part2.find_repeat

    assert expect == result
  end

  test "Detects repeats 3" do
    input = "abcdefeghi"
    expect = true

    result = input
             |> Day5.Part2.split_word
             |> Day5.Part2.find_repeat

    assert expect == result
  end

  test "Passes rules" do
    input = "qjhvhtzxzqqjkmpb"
    expect = true
    result = Day5.Part2.test(input)

    assert expect == result
  end

  test "Passes rules as well" do
    input = "xxyxx"
    expect = true
    result = Day5.Part2.test(input)

    assert expect == result
  end

  test "Fails rules for no repeat" do
    input = "uurcxstgmygtbstg"
    expect = false
    result = Day5.Part2.test(input)

    assert expect == result
  end

  test "Fails rules for no duplicate 1" do
    input = "ieodomkazucvgmuy"
    expect = false
    result = Day5.Part2.test(input)

    assert expect == result
  end

  test "Processes multiple lines" do
    input = [
      "qjhvhtzxzqqjkmpb",
      "xxyxx",
      "uurcxstgmygtbstg",
      "ieodomkazucvgmuy"
    ]
    expect = [
      "qjhvhtzxzqqjkmpb",
      "xxyxx",
    ]

    result = Day5.Part2.process(input)
    assert expect == result
  end
end
