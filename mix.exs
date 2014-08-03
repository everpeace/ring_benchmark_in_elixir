defmodule RingBenchmarkInElixir.Mixfile do
  use Mix.Project

  def project do
    [app: :ring_benchmark,
     escript: escript,
     version: "0.0.1",
     elixir: "~> 0.14.3",
     deps: deps]
  end

  def escript do
    [ main_module: Ringbenchmark ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: []]
  end

  # Dependencies can be hex.pm packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:benchmark, github: "everpeace/elixir-benchmark", branch: "feature/report_results"}]
  end
end
