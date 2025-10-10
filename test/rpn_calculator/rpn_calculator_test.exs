defmodule RPNCalculator.RPNCalculatorTest do
  use ExUnit.Case

  alias RPNCalculator.RPNCalculator

  test "simple addition" do
    rpn_calculator =
      %RPNCalculator{}
      |> RPNCalculator.process_keys(["1", "Enter", "2", "Add"])

    assert RPNCalculator.top_of_stack(rpn_calculator) == 3
  end

  test "input editing" do
    rpn_calculator =
      %RPNCalculator{}
      |> RPNCalculator.process_keys(["1", "2", "Sign", "Backspace", "Dot", "5"])

    assert RPNCalculator.top_of_stack(rpn_calculator) == -1.5
  end

  test "xy swap" do
    rpn_calculator =
      %RPNCalculator{}
      |> RPNCalculator.process_keys(["1", "Enter", "2", "XY"])

    assert RPNCalculator.top_of_stack(rpn_calculator) == 1
    assert rpn_calculator.rpn_stack == [1, 2]
  end

  test "roll up down drops" do
    rpn_calculator =
      %RPNCalculator{}
      |> RPNCalculator.process_keys([
        "1",
        "Enter",
        "2",
        "Enter",
        "3",
        "Enter",
        "4",
        "RollUp",
        "Drop",
        "RollDown",
        "Drop"
      ])

    assert RPNCalculator.top_of_stack(rpn_calculator) == 1
    assert rpn_calculator.rpn_stack == [1, 2]
  end
end
