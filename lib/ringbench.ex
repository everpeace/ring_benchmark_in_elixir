defmodule Ringbenchmark do

  def main(args) do
    [n, m | _tail] = :lists.map(fn x -> String.to_integer(x) end, args)
    start(n, m)
    exit(:normal)
  end

  defp start(n, m) do
    :erlang.statistics(:runtime)
    :erlang.statistics(:wall_clock)
    _main = self()
    root = Ring.init(_main, n, m)
    IO.puts "[main(#{inspect(self())})] injecting the token \"#{m}\" times."
    send root, {_main, :token}
    receive do
      :ended -> :void
    end
    send root, {_main, :kill}
    {_, time1} = :erlang.statistics(:runtime)
    {_, time2} = :erlang.statistics(:wall_clock)
    IO.puts "[main(~#{inspect(self())})] ring benchmark for #{n} processes and #{m} tokens = #{time1} (#{time2}) milliseconds"
  end
end
