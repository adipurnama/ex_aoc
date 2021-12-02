defmodule Aoc202102 do
  require Logger

  def run do
    cmds = navigation_commands() |> Enum.to_list()
    Logger.info("part1 = #{part1(cmds)}")
    Logger.info("part2 = #{part2(cmds)}")
  end

  def part1(cmds) do
    {x, depth} = navigate({0, 0}, cmds, &apply_cmd_part1/2)
    x * depth
  end

  def part2(cmds) do
    {x, depth, _aim} = navigate({0, 0, 0}, cmds, &apply_cmd_part2/2)
    x * depth
  end

  defp navigate(stat, cmds, _apply_cmd) when length(cmds) == 0 do
    stat
  end

  defp navigate(stat, [cmd], apply_cmd) do
    apply_cmd.(stat, cmd)
  end

  defp navigate(stat, [cmd | rest], apply_cmd) do
    new_stat = apply_cmd.(stat, cmd)
    navigate(new_stat, rest, apply_cmd)
  end

  defp apply_cmd_part1({x, depth}, cmd) do
    case cmd do
      {:forward, n} ->
        {x + n, depth}

      {:up, n} ->
        {x, depth - n}

      {:down, n} ->
        {x, depth + n}
    end
  end

  defp apply_cmd_part2({x, depth, aim}, cmd) do
    case cmd do
      {:forward, n} ->
        {x + n, depth + aim * n, aim}

      {:up, n} ->
        {x, depth, aim - n}

      {:down, n} ->
        {x, depth, aim + n}
    end
  end

  def navigation_commands do
    Stream.map(Aoc.input_lines(__MODULE__), &parse_command/1)
  end

  defp parse_command("forward " <> count) do
    {:forward, String.to_integer(count)}
  end

  defp parse_command("up " <> count) do
    {:up, String.to_integer(count)}
  end

  defp parse_command("down " <> count) do
    {:down, String.to_integer(count)}
  end
end
