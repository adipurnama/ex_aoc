defmodule Aoc202101 do
  require Logger

  def run do
    Logger.info("part1 #{part1()}")
    Logger.info("part2 #{part2()}")
  end

  defp part1 do
    depth_measurements()
    |> increased_depths()
  end

  defp part2 do
    depth_measurements()
    |> Enum.to_list()
    |> next_three_window()
    |> Enum.map(fn [a, b, c] -> a + b + c end)
    |> increased_depths()
  end

  defp next_three_window(list) when length(list) >= 3 do
    window = Enum.take(list, 3)
    rem = Enum.drop(list, 1)
    [window | next_three_window(rem)]
  end

  defp next_three_window(_list) do
    []
  end

  defp increased_depths(depths) do
    {_, count} =
      depths
      |> Enum.reduce({nil, 0}, fn depth, {prev, count} ->
        cond do
          prev == nil ->
            {depth, 0}

          prev < depth ->
            {depth, count + 1}

          true ->
            {depth, count}
        end
      end)

    count
  end

  defp depth_measurements do
    Stream.map(Aoc.input_lines(__MODULE__), &String.to_integer/1)
  end
end
