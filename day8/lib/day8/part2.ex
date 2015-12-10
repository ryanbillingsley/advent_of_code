defmodule Day8.Part2 do

  def start(input) do
    results = File.read!(input)
              |> String.split("\n")
              |> Enum.filter(&(&1 != ""))
              |> Enum.reduce(%{code: 0, len: 0, encoded: 0}, fn(str, acc) ->
                {code, len, encoded, _string} = parse(str)
                %{code: acc.code + code, len: acc.len + len, encoded: acc.encoded + encoded}
              end)

    IO.inspect results
    IO.puts "Part1: #{results.code - results.len}"
    IO.puts "Part2: #{results.encoded - results.code}"
  end

  def parse(string) do
    IO.puts "Parsing #{string}"
    res = _parse(string, %{encoded: 4, code: 0, len: 0, str: ""})
    IO.puts "Results\n"
    IO.inspect res
    IO.puts "---------------------------------------------------------------------\n\n"
    {res.code, res.len, res.encoded, String.reverse(res.str)}
  end

  # end quote
  def _parse("\"", res = %{code: code, encoded: encoded}), do: %{res | code: code + 1, encoded: encoded + 1}

  # open quote
  def _parse("\"" <> tail, res = %{code: code, encoded: encoded}), do: _parse(tail, %{res| code: code + 1, encoded: encoded + 1})

  # escaped quote
  def _parse("\\\"" <> tail, res),
    do: _parse( tail, %{code: res.code + 2, len: res.len+1, encoded: res.encoded + 4, str: "\"" <> res.str})

  # escaped backslash
  def _parse("\\\\" <> tail, res),
    do: _parse( tail, %{code: res.code + 2, len: res.len+1, encoded: res.encoded + 4, str: "\\" <> res.str})

  # escaped hex val
  def _parse("\\x" <> << hex_val :: binary-size(2) >> <> tail, res) do
    case Base.decode16(String.upcase(hex_val)) do
      {:ok, c} -> _parse(tail, %{code: res.code + 4, len: res.len + 1, encoded: res.encoded + 5, str: c <> res.str})
      :error -> raise(RuntimeError, %{hex_val: hex_val, res: res, tail: tail})
    end

  end

  def _parse(<<c :: utf8, tail :: binary>>, res),
    do: _parse(tail, %{code: res.code + 1, len: res.len + 1, encoded: res.encoded + 1, str: <<c :: utf8, res.str :: binary>>})

  def _parse(v, res), do: raise(RuntimeError, %{v: v, res: res})
end
