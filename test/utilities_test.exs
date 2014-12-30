defmodule UtilitiesTest do
  use ExUnit.Case

  test "random_uniform_value" do
    assert CleverElixirAlgorithms.Utilities.random_uniform_value > 0
    assert CleverElixirAlgorithms.Utilities.random_uniform_value <= 1
    assert CleverElixirAlgorithms.Utilities.random_uniform_value(5) > 0
    assert CleverElixirAlgorithms.Utilities.random_uniform_value(5) <= 5
    assert CleverElixirAlgorithms.Utilities.random_uniform_value([5, 7]) > 5
    assert CleverElixirAlgorithms.Utilities.random_uniform_value([5, 7]) <= 7
  end

  test "get_objective_fn" do
    objective = CleverElixirAlgorithms.Utilities.get_objective_fn fn x -> x*x end, fn x, y -> x + y end
    assert objective.([1, 2, 3, 4,]) == 30
  end

  test "random_sample_fn" do
    random_sample = CleverElixirAlgorithms.Utilities.random_sample_fn 10, [5, 7]
    assert length(random_sample.()) == 10
    assert Enum.reduce(random_sample.(), true, fn(x, acc) -> acc && (x > 5) && (x <= 7) end)

    random_sample = CleverElixirAlgorithms.Utilities.random_sample_fn 10, 5
    assert length(random_sample.()) == 10
    assert Enum.reduce(random_sample.(), true, fn(x, acc) -> acc && (x > 0) && (x <= 5) end)

    random_sample = CleverElixirAlgorithms.Utilities.random_sample_fn 10
    assert length(random_sample.()) == 10
    assert Enum.reduce(random_sample.(), true, fn(x, acc) -> acc && (x > 0) && (x <= 1) end)
  end

  test "cost_compare_fn" do
    objective = CleverElixirAlgorithms.Utilities.get_objective_fn fn x -> x*x end, fn x, y -> x + y end
    cost_compare = CleverElixirAlgorithms.Utilities.cost_compare_fn objective
    assert cost_compare.([1, 2, 3, 4], [5, 6, 7, 8]) == [1, 2, 3, 4]
  end
end
