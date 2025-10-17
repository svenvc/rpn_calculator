defmodule RPNCalculator.HP35Test do
  use ExUnit.Case

  alias RPNCalculator.RPNCalculator

  @moduledoc """
  These are literal examples from the original HP-35 manual from the early seventies.
  """

  # page 3

  test "sum of the first 5 odd numbers" do
    assert_sequence([
      {"1", 1},
      {"Enter", 1},
      {"3", 3},
      {"Add", 4},
      {"5", 5},
      {"Add", 9},
      {"7", 7},
      {"Add", 16},
      {"9", 9},
      {"Add", 25}
    ])
  end

  test "product of the first 5 even numbers" do
    assert_sequence([
      {"2", 2},
      {"Enter", 2},
      {"4", 4},
      {"Multiply", 8},
      {"6", 6},
      {"Multiply", 48},
      {"8", 8},
      {"Multiply", 384},
      {"1", 1},
      {"0", 10},
      {"Multiply", 3840}
    ])
  end

  # page 8

  test "square root of 49" do
    assert_sequence([
      {"4", 4},
      {"9", 49},
      {"Sqrt", 7}
    ])
  end

  test "reciprocal of 25" do
    assert_sequence([
      {"2", 2},
      {"5", 25},
      {"Reciprocal", 0.04}
    ])
  end

  defp assert_sequence(steps) do
    Enum.map_reduce(steps, %RPNCalculator{}, fn {key, result}, rpn_calculator ->
      rpn_calculator = RPNCalculator.process_key(rpn_calculator, key)
      assert RPNCalculator.top_of_stack(rpn_calculator) == result
      {key , rpn_calculator}
    end)
  end
end
