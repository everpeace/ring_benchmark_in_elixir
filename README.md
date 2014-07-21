Ring Benchmark in [Elixir](http://elixir-lang.org/)
================================

This is another implementation in [Elixir](http://elixir-lang.org/) of [Ring Benchmark](http://github.com/everpeace/ring-benchmark) which is originally written in Erlang.

The Problem is:
> Write a ring benchmark. Create N processes in a ring. Send a message round the ring M times so that a total of N * M messages get sent.
> Time how long this takes for different values of N and M.

How to build
----
```
$ mix compile
Compiled lib/ringbench.ex
Compiled lib/ring.ex
Generated ring_benchmark.app

$ mix escriptize
Generated escript ring_benchmark
```
How to run
------------
An example below is `N=4, M=3`.

```
$ ./ring_benchmark 4 3
[main(#PID<0.2.0>)] constructing 4 nodes ring...
[main(#PID<0.2.0>)] injecting the token "3" times.
[0(#PID<0.37.0>)] starting...
[1(#PID<0.38.0>)] starting...
[2(#PID<0.39.0>)] starting...
[3(#PID<0.40.0>)] starting...
[0(#PID<0.37.0>)] token ":token" is injected from #PID<0.2.0>. the token starts rounding in the ring.
[1(#PID<0.38.0>)] token "{0, :token}" received. forwading to #PID<0.39.0>.
[2(#PID<0.39.0>)] token "{0, :token}" received. forwading to #PID<0.40.0>.
[3(#PID<0.40.0>)] token "{0, :token}" received. forwading to #PID<0.37.0>.
[0(#PID<0.37.0>)] token ":token" reaches root 1 times.
[1(#PID<0.38.0>)] token "{1, :token}" received. forwading to #PID<0.39.0>.
[2(#PID<0.39.0>)] token "{1, :token}" received. forwading to #PID<0.40.0>.
[3(#PID<0.40.0>)] token "{1, :token}" received. forwading to #PID<0.37.0>.
[0(#PID<0.37.0>)] token ":token" reaches root 2 times.
[1(#PID<0.38.0>)] token "{2, :token}" received. forwading to #PID<0.39.0>.
[2(#PID<0.39.0>)] token "{2, :token}" received. forwading to #PID<0.40.0>.
[3(#PID<0.40.0>)] token "{2, :token}" received. forwading to #PID<0.37.0>.
[0(#PID<0.37.0>)] token ":token" reaches root 3 times.
[0(#PID<0.37.0>)] report the finish of benchmark to main(#PID<0.2.0>).
[1(#PID<0.38.0>)] exitting...
[main(~#PID<0.2.0>)] ring benchmark for 4 processes and 3 tokens = 10 (13) milliseconds
```

Licence
------------
under MIT License.  See also LICENSE.txt

Copyright
------------
copyright 2014- [everpeace](http://twitter.com/everpeace).
