# Used whenever a router fails. We default to simply
# rendering a short string.
defmodule CleverElixirAlgorithmsTestHelper do
  def is_min?(value, candidates), do: _is_min?(value, candidates, true)

  defp _is_min?(_, [], min?), do: min?
  defp _is_min?(_, _, false), do: false
  defp _is_min?(value, [ head | tail ], true), do: _is_min?(value, tail, value <= head)
end

ExUnit.start()
