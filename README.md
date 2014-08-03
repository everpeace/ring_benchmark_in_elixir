Ring Benchmark in [Elixir](http://elixir-lang.org/)
================================

This is another implementation in [Elixir](http://elixir-lang.org/) of [Ring Benchmark](http://github.com/everpeace/ring-benchmark) which is originally written in Erlang.

The Problem is:
> Write a ring benchmark. Create N processes in a ring. Send a message round the ring M times so that a total of N * M messages get sent.
> Time how long this takes for different values of N and M.

How to build
----
This depends on elixir 0.14.3 or above (`~> "0.14.3"`).

```
$ mix deps.get
* Getting benchmark (git://github.com/everpeace/elixir-benchmark.git)
...
Resolving deltas: 100% (30/30), done.

$ mix escript.build
lib/benchmark.ex:148: warning: function run_for_executor/4 is unused
==> benchmark
Compiled lib/benchmark.ex
Generated benchmark.app
==> ring_benchmark
Compiled lib/ringbench.ex
Compiled lib/ring.ex
Generated ring_benchmark.app
Generated escript ring_benchmark
```
How to run
------------
An example below is `# of trial=1, N=4, M=3`.

```
$ ./ring_benchmark 1 4 3
[main(#PID<0.38.0>)] constructing 4 nodes ring...
[main(#PID<0.38.0>)] injecting the token "3" times.
[0(#PID<0.39.0>)] starting...
[1(#PID<0.40.0>)] starting...
[2(#PID<0.41.0>)] starting...
[3(#PID<0.42.0>)] starting...
[0(#PID<0.39.0>)] token ":token" is injected from #PID<0.38.0>. the token starts rounding in the ring.
[1(#PID<0.40.0>)] token "{0, :token}" received. forwading to #PID<0.41.0>.
[2(#PID<0.41.0>)] token "{0, :token}" received. forwading to #PID<0.42.0>.
[3(#PID<0.42.0>)] token "{0, :token}" received. forwading to #PID<0.39.0>.
[0(#PID<0.39.0>)] token ":token" reaches root 1 times.
[1(#PID<0.40.0>)] token "{1, :token}" received. forwading to #PID<0.41.0>.
[2(#PID<0.41.0>)] token "{1, :token}" received. forwading to #PID<0.42.0>.
[3(#PID<0.42.0>)] token "{1, :token}" received. forwading to #PID<0.39.0>.
[0(#PID<0.39.0>)] token ":token" reaches root 2 times.
[1(#PID<0.40.0>)] token "{2, :token}" received. forwading to #PID<0.41.0>.
[2(#PID<0.41.0>)] token "{2, :token}" received. forwading to #PID<0.42.0>.
[3(#PID<0.42.0>)] token "{2, :token}" received. forwading to #PID<0.39.0>.
[0(#PID<0.39.0>)] token ":token" reaches root 3 times.
[0(#PID<0.39.0>)] report the finish of benchmark to main(#PID<0.38.0>).
[main(#PID<0.38.0>)] killing the ring.
[1(#PID<0.40.0>)] exitting...
[2(#PID<0.41.0>)] exitting...
[3(#PID<0.42.0>)] exitting...
[0(#PID<0.39.0>)] exitting...
[min: 11.083 milliseconds, max: 11.083 milliseconds, average: 11.083 milliseconds, total: 11.083 milliseconds, length: 1, results: [{11.083 milliseconds, :ok}]]
```

Licence
------------
under MIT License.  See also LICENSE.txt

Copyright
------------
copyright 2014- [everpeace](http://twitter.com/everpeace).
