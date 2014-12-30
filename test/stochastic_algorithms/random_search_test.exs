defmodule RandomSearchTest do
  use ExUnit.Case

  setup do
    { :ok, problem: %{
        problem_size: 2,
        max_iter: 100,
        search_space: [-5, 5],
        cost: fn x -> x*x end
      }
    }
  end

  test "algorithm 2.2.1 implementation as proxy for RandomSearch.search", meta do
    %{ best: best, candidates: candidates } = CleverElixirAlgorithms.StochasticAlgorithms.RandomSearch.algorithm_2_2_1(meta[:problem])
    assert CleverElixirAlgorithmsTestHelper.is_min? best, candidates
  end
end
