defmodule CleverElixirAlgorithms.StochasticAlgorithms.RandomSearch do
  alias CleverElixirAlgorithms.Utilities, as: Utils

  def algorithm_2_2_1(%{ problem_size: problem_size, max_iter: mi, search_space: sample_space, cost: cost_fn }) do
    iterations = Range.new(1, mi)
    objective = Utils.get_objective_fn cost_fn, fn x, y -> x + y end
    cost_compare = Utils.cost_compare_fn objective
    random_sample = Utils.random_sample_fn problem_size, sample_space

    candidates = Enum.map iterations, fn(_) -> random_sample.() end
    best = Enum.reduce(candidates, cost_compare)
    %{ best: objective.(best), candidates: Enum.map(candidates, objective) }
  end

  def search(%{ problem_size: problem_size, max_iter: mi, search_space: sample_space, cost: cost_fn }) do
    iterations = Range.new(1, mi)
    objective = Utils.get_objective_fn cost_fn, fn x, y -> x + y end
    cost_compare = Utils.cost_compare_fn objective
    random_sample = Utils.random_sample_fn problem_size, sample_space

    Enum.reduce(iterations, random_sample.(), fn(_, acc) -> cost_compare.(random_sample.(), acc) end)
  end
end
