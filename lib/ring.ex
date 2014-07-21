defmodule Ring do

  def init(_, n, m) when (n < 1) or (m < 1) do
    IO.puts "N and M must be larger than 1."
    exit({:n_must_be_positive, :m_must_be_positive})
  end

  def init(main, n, m) do
    IO.puts "[main(#{inspect(self())})] constructing #{n} nodes ring..."
    root = root_start(0, main, m)
    first = create_nodes(1, n-1, root)
    send root, {:link, first}
    root
  end

  defp create_nodes(_, 0, root) do
    root
  end
  defp create_nodes(n, n, root) do
    node = node_start(n)
    send node, {:link, root}
    node
  end
  defp create_nodes(i, n, root) do
    node = node_start(i)
    next = create_nodes(i+1, n, root)
    send node, {:link, next}
    node
  end

  # Ordinal Node
  defp node_start(name) do
    spawn fn ->
            IO.puts "[#{name}(#{inspect(self())})] starting..."
            wait_for_link(name)
    end
  end

  defp wait_for_link(name) do
    receive do
      {:link, next} ->
        listen_tokens(name, next)
    end
  end

  defp listen_tokens(name, next) do
    receive do
      :kill ->
        forward_kill(name, next)
      token ->
        forward_token(name, token, next)
        listen_tokens(name, next)
    end
  end

  defp forward_token(name, token, next) do
    IO.puts "[#{name}(#{inspect(self())})] token \"#{inspect(token)}\" received. forwading to #{inspect(next)}."
    send next, token
  end

  defp forward_kill(name, next) do
      IO.puts "[#{name}(#{inspect(self())})] exitting..."
      send next, :kill
  end

  # Root node
  defp root_start(name, main, m) do
    spawn fn ->
            IO.puts "[#{name}(#{inspect(self())})] starting..."
            wait_for_link(name, main, m)
          end
  end

  defp wait_for_link(name, main, m) do
    receive do
      {:link, next} ->
        listen_tokens(name, main, next, m)
    end
  end

  defp listen_tokens(name, main, next, m) do
    receive do
      # interfaces with main process.
      {^main, :kill} ->
        send next, :kill
        listen_tokens(name, main, next, m)

      {^main, token} ->
       IO.puts "[#{name}(#{inspect(self())})] token \"#{inspect(token)}\" is injected from #{inspect(main)}. the token starts rounding in the ring."
       send next, {0, token}
       listen_tokens(name, main, next, m)

      # rounding the token.
      {i, token} when i === m-1 ->
        IO.puts "[#{name}(#{inspect(self())})] token \"#{inspect(token)}\" reaches root #{m} times."
        IO.puts "[#{name}(#{inspect(self())})] report the finish of benchmark to main(#{inspect(main)})."
        send main, :ended
        listen_tokens(name, main, next, m);

      {i, token} ->
        IO.puts "[#{name}(#{inspect(self())})] token \"#{inspect(token)}\" reaches root #{i+1} times."
        send next, {i+1, token}
        listen_tokens(name, main, next, m);

      # kill self.
      :kill ->
        IO.puts "[#{name}(#{inspect(self())})] exitting..."
    end
  end
end
