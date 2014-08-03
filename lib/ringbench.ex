defmodule Ringbenchmark do
  require Benchmark

  def main(args) do
    [t, n, m | _tail] = :lists.map(fn x -> String.to_integer(x) end, args)
    start(t, n, m)
    exit(:normal)
  end

  defp start(t, n, m) do
    result = Benchmark.times t, do: try(n,m)
    IO.puts "#{inspect(result)}"
  end

  defp try(n, m) do
    _main = self()
    root = Ring.init(_main, n, m)
    IO.puts "[main(#{inspect(self())})] injecting the token \"#{m}\" times."
    send root, {_main, :token}
    receive do
      :ended -> send root, {_main, :kill}
    end
    IO.puts "[main(#{inspect(self())})] killing the ring."
  end
end
