defmodule CleverElixirAlgorithms.Utilities do
  def random_uniform_value do
    << a :: 32, b :: 32, c :: 32 >> = :crypto.rand_bytes(12)
    :random.seed(a,b,c)
    :random.uniform
  end

  def random_uniform_value(x) when is_number(x) do
    random_uniform_value * x
  end

  def random_uniform_value([ min | [ max | [] ] ]) when is_number(min) and is_number(max) and min < max do
    min + random_uniform_value * (max - min)
  end

  def random_sample_fn problem_size do
    fn -> Enum.map(Range.new(1, problem_size), fn(_) -> CleverElixirAlgorithms.Utilities.random_uniform_value end) end
  end

  def random_sample_fn problem_size, sample_space do
    fn -> Enum.map(Range.new(1, problem_size), fn(_) -> CleverElixirAlgorithms.Utilities.random_uniform_value(sample_space) end) end
  end

  def get_objective_fn cost_fn, acc_fn do
    fn estimates -> Enum.reduce(estimates, 0, fn(x, acc) -> acc_fn.(cost_fn.(x), acc) end) end
  end

  def cost_compare_fn objective_fn do
    fn first_sample, second_sample -> if objective_fn.(second_sample) <= objective_fn.(first_sample), do: second_sample, else: first_sample end
  end
end
