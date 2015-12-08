defmodule Day7.Part1 do
  use Bitwise

  def start(input \\ "input.txt") do
    inputs = File.read!(input)
              |> String.split(~r{\n})
              |> Enum.filter(&(&1 != ""))
              |> Enum.map(&convert_signal/1)

    results = inputs
              |> process(HashDict.new)

    IO.puts "Result A: #{results["a"]}"

    b_index = inputs
              |> Enum.find_index(&(&1.target == "b"))

    b_signal = inputs
               |> Enum.find(&(&1.target == "b"))
    b_signal = %{b_signal | source: results["a"]}
    IO.puts "New B Signal: "
    IO.inspect b_signal

    second_results = List.replace_at(inputs, b_index, b_signal)
                     |> process(HashDict.new)

    IO.puts "Result A: #{second_results["a"]}"
  end

  def convert_signal(line) do
    line
    |> String.split(" ")
    |> Enum.map(fn(val) ->
      case Integer.parse(val) do
        :error -> val
        {int, _} -> int
      end
    end)
    |> parse_line
  end

  def parse_line([line_input,"->",target]) when is_number(line_input) do
    %{op: :input, source: line_input, target: target}
  end

  def parse_line([line_input,"->",target]) when is_binary(line_input) do
    %{op: :line, source: line_input, target: target}
  end

  def parse_line(["NOT",source,"->",target]) do
    %{op: :not, source: source, target: target}
  end

  def parse_line([source,"LSHIFT",quantity,"->",target]) do
    %{op: :lshift, source: source, quantity: quantity, target: target}
  end

  def parse_line([source,"RSHIFT",quantity,"->",target]) do
    %{op: :rshift, source: source, quantity: quantity, target: target}
  end

  def parse_line([source1,"AND",source2,"->",target]) do
    %{op: :and, source: [source1,source2], target: target}
  end

  def parse_line([source1,"OR",source2,"->",target]) do
    %{op: :or, source: [source1,source2], target: target}
  end

  def process([], acc), do: acc
  def process([%{ source: source} = signal|rest], acc) when is_number(source) do
    results = Dict.put(acc, signal.target, source)
    process(rest, results)
  end
  def process([%{ source: source } = signal|rest], acc) when is_binary(source) do
    case Dict.fetch(acc, source) do
      {:ok, value} ->
        result = calculate(value, signal)
        results = Dict.put(acc, signal.target, result)
        process(rest, results)
      :error ->
        signals = List.insert_at(rest, Enum.count(rest), signal)
        process(signals, acc)
    end
  end
  def process([%{ source: source} = signal|rest], acc) when is_list(source) do
    fetched = Enum.map(source, fn(s) ->
      if is_number(s) do
        s
      else
        case Dict.fetch(acc, s) do
          {:ok, value} -> value
          :error -> nil
        end
      end
    end)

    if Enum.any?(fetched, &(&1 == nil)) do
      signals = List.insert_at(rest, Enum.count(rest), signal)
      process(signals, acc)
    else
      result = calculate(fetched, signal)
      results = Dict.put(acc, signal.target, result)
      process(rest, results)
    end
  end

  def calculate(value, op) do
    result = _do_calc(value, op)
    band(result,0xFFFF)
  end

  defp _do_calc(value, %{op: :line}), do: value
  defp _do_calc(value, %{op: :not}), do: bnot(value)
  defp _do_calc([value1, value2], %{op: :or}), do: bor(value1,value2)
  defp _do_calc([value1, value2], %{op: :and}), do: band(value1,value2)
  defp _do_calc(value, %{op: :lshift, quantity: quantity}), do: bsl(value,quantity)
  defp _do_calc(value, %{op: :rshift, quantity: quantity}), do: bsr(value,quantity)
end
