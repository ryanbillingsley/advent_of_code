defmodule Day15 do
  def start(input) do
    File.read!(input)
    |> String.split(~r/\n/)
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&parse_ingredient/1)
  end

  def parse_ingredient(input) do
    regex = ~r/(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)$/
    [_all,name,capacity,durability,flavor,texture,calories] = Regex.run(regex, input)
    %{ name: name, capacity: capacity, durability: durability, flavor: flavor, texture: texture, calories: calories }
  end
end
