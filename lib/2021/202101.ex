defmodule Aoc202101 do
  require Logger

  def run do
    Logger.info("part1 #{part1()}")
    Logger.info("part2 #{part2()}")
  end

  defp part1 do
    depth_measurements()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> b > a end)
  end

  defp part2 do
    depth_measurements()
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [[a, b, c], [d, e, f]] -> a + b + c < d + e + f end)
  end

  defp depth_measurements do
    Stream.map(Aoc.input_lines(__MODULE__), &String.to_integer/1)
  end
end
