defmodule Day11 do
  def start(password) do
    new_password = password
                   |> next


    IO.puts "Your new password is #{new_password}"
  end

  def next(password) do
    new_password = password
            |> to_char_list
            |> Enum.reverse
            |> increment
            |> List.flatten
            |> Enum.reverse
            |> List.to_string

    IO.puts new_password

    if valid?(new_password) do
      new_password
    else
      next(new_password)
    end
  end

  def increment([]), do: []
  def increment([head|tail]) when head + 1 > 122, do: [(head+1) - 26,increment(tail)]
  def increment([head|tail]) when head + 1 < 97, do: [(head+1) + 97,tail]
  def increment([head|tail]), do: [(head+1),tail]

  def valid?(password) do
    straight_run?(password) and all_valid?(password) and double_letter?(password)
  end

  def straight_run?(password) do
    password
    |> to_char_list
    |> Enum.chunk(3,1)
    |> Enum.filter(fn([first,second,third]) ->
      (first + 1) == second and second + 1 == third
    end)
    |> Enum.count >= 1
  end

  def all_valid?(password) do
    !Regex.match?(~r/[iol]/, password)
  end

  def double_letter?(password) do
    Regex.match?(~r/(\w)\1.*([^\1])\2/,password)
  end
end
