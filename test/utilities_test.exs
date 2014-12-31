defmodule UtilitiesTest do
  use ExUnit.Case
  alias CleverElixirAlgorithms.Utilities, as: Utils

  test "random_uniform_value" do
    assert Utils.random_uniform_value > 0
    assert Utils.random_uniform_value <= 1
    assert Utils.random_uniform_value(5) > 0
    assert Utils.random_uniform_value(5) <= 5
    assert Utils.random_uniform_value([5, 7]) > 5
    assert Utils.random_uniform_value([5, 7]) <= 7
  end

  test "get_objective_fn" do
    objective = Utils.get_objective_fn fn x -> x*x end, fn x, y -> x + y end
    assert objective.([1, 2, 3, 4,]) == 30
  end

  test "random_sample_fn" do
    random_sample = Utils.random_sample_fn 10, [5, 7]
    assert length(random_sample.()) == 10
    assert Enum.reduce(random_sample.(), true, fn(x, acc) -> acc && (x > 5) && (x <= 7) end)

    random_sample = Utils.random_sample_fn 10, 5
    assert length(random_sample.()) == 10
    assert Enum.reduce(random_sample.(), true, fn(x, acc) -> acc && (x > 0) && (x <= 5) end)

    random_sample = Utils.random_sample_fn 10
    assert length(random_sample.()) == 10
    assert Enum.reduce(random_sample.(), true, fn(x, acc) -> acc && (x > 0) && (x <= 1) end)
  end

  test "cost_compare_fn" do
    objective = Utils.get_objective_fn fn x -> x*x end, fn x, y -> x + y end
    cost_compare = Utils.cost_compare_fn objective
    assert cost_compare.([1, 2, 3, 4], [5, 6, 7, 8]) == [1, 2, 3, 4]
  end
end
