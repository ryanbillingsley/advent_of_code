defmodule Seatings do
  @name __MODULE__

  def start_link(input), do: Agent.start_link(fn -> input end, name: @name)
  def stop, do: Agent.stop(@name)

  def find_seating(source, target) do
    Agent.get(@name, fn(seatings) ->
      seatings
      |> Enum.find(&((&1.source == source and &1.target == target)))
    end)
  end

  def targets_for_source(source) do
    Agent.get(@name, fn(seatings) ->
      seatings
      |> Enum.filter(&(&1.source == source))
    end)
  end

  def contents do
    Agent.get(@name, &(&1))
  end
end
