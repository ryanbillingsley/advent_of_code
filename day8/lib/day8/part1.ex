defmodule Day8.Part1 do

  def start(input) do
    results = File.read!(input)
              |> String.split("\n")
              |> Enum.filter(&(&1 != ""))
              |> Enum.reduce(%{code: 0, len: 0}, fn(str, acc) ->
                {code, len, _string} = parse(str)
                %{code: acc.code + code, len: acc.len + len}
              end)

    results.code - results.len
  end

  def parse(string) do
    res = _parse(string, %{code: 0, len: 0, str: ""})
    {res.code, res.len, String.reverse(res.str)}
  end

  # end quote
  def _parse("\"", res = %{code: code}), do: Map.put(res, :code, code + 1)

  # open quote
  def _parse("\"" <> tail, res = %{code: code}), do: _parse(tail, Map.put(res, :code, code + 1))

  # escaped quote
  def _parse("\\\"" <> tail, res),
    do: _parse( tail, %{code: res.code + 2, len: res.len+1, str: "\"" <> res.str})

  # escaped backslash
  def _parse("\\\\" <> tail, res),
    do: _parse( tail, %{code: res.code + 2, len: res.len+1, str: "\\" <> res.str})

  # escaped hex val
  def _parse("\\x" <> << hex_val :: binary-size(2) >> <> tail, res) do
    case Base.decode16(String.upcase(hex_val)) do
      {:ok, c} -> _parse(tail, %{code: res.code + 4, len: res.len + 1, str: c <> res.str})
      :error -> raise(RuntimeError, %{hex_val: hex_val, res: res, tail: tail})
    end

  end

  def _parse(<<c :: utf8, tail :: binary>>, res),
    do: _parse(tail, %{code: res.code + 1, len: res.len + 1, str: <<c :: utf8, res.str :: binary>>})

  def _parse(v, res), do: raise(RuntimeError, %{v: v, res: res})
end
