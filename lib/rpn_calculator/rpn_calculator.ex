defmodule RPNCalculator.RPNCalculator do
  defstruct rpn_stack: [0], input_digits: ""

  def process_key(%__MODULE__{} = rpn_calculator, key)
      when key in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] do
    rpn_calculator
    |> Map.update!(:input_digits, fn input_digits ->
      cond do
        input_digits == "0" -> key
        true -> input_digits <> key
      end
    end)
    |> update_x()
  end

  def process_key(%__MODULE__{} = rpn_calculator, "Dot") do
    rpn_calculator
    |> Map.update!(:input_digits, fn input_digits ->
      if String.contains?(input_digits, ".") do
        input_digits
      else
        if input_digits == "" do
          "0."
        else
          input_digits <> "."
        end
      end
    end)
    |> update_x()
  end

  def process_key(%__MODULE__{} = rpn_calculator, "Sign") do
    rpn_calculator
    |> Map.update!(:input_digits, fn input_digits ->
      cond do
        input_digits == "" -> ""
        String.first(input_digits) == "-" -> String.slice(input_digits, 1..-1//1)
        true -> "-" <> input_digits
      end
    end)
    |> update_x()
  end

  def process_key(%__MODULE__{} = rpn_calculator, "Clear") do
    rpn_calculator
    |> clear_input()
    |> update_x()
  end

  def process_key(%__MODULE__{} = rpn_calculator, "Backspace") do
    rpn_calculator
    |> Map.update!(:input_digits, fn input_digits ->
      cond do
        String.length(input_digits) == 2 and String.first(input_digits) == "-" -> ""
        true -> String.slice(input_digits, 0..-2//1)
      end
    end)
    |> update_x()
  end

  def process_key(%__MODULE__{} = rpn_calculator, "Enter") do
    rpn_calculator
    |> Map.update!(:rpn_stack, fn [top | tail] -> [top | [top | tail]] end)
    |> clear_input()
  end

  def process_key(%__MODULE__{} = rpn_calculator, "Add") do
    rpn_calculator
  end

  def process_key(%__MODULE__{} = rpn_calculator, "Subtract") do
    rpn_calculator
  end

  def process_key(%__MODULE__{} = rpn_calculator, "Multiply") do
    rpn_calculator
  end

  def process_key(%__MODULE__{} = rpn_calculator, "Divide") do
    rpn_calculator
  end

  def process_key(%__MODULE__{} = rpn_calculator, "XY") do
    rpn_calculator
    |> Map.update!(:rpn_stack, fn
      [x | [y | tail]] -> [y | [x | tail]]
      rpn_stack -> rpn_stack
    end)
    |> clear_input()
  end

  def process_key(%__MODULE__{} = rpn_calculator, "RollDown") do
    rpn_calculator
  end

  def process_key(%__MODULE__{} = rpn_calculator, "RollUp") do
    rpn_calculator
  end

  def process_key(%__MODULE__{} = rpn_calculator, "Drop") do
    rpn_calculator
    |> Map.update!(:rpn_stack, fn
      [top] -> [top]
      [_top | tail] -> tail
    end)
  end

  def process_keys(%__MODULE__{} = rpn_calculator, keys) when is_list(keys) do
    Enum.reduce(
      keys,
      rpn_calculator,
      fn key, rpn_calculator -> process_key(rpn_calculator, key) end
    )
  end

  defp update_x(%__MODULE__{} = rpn_calculator) do
    new_x = parse_input(rpn_calculator.input_digits)

    rpn_calculator
    |> Map.update!(:rpn_stack, fn [_top | tail] -> [new_x | tail] end)
  end

  defp clear_input(%__MODULE__{} = rpn_calculator) do
    rpn_calculator
    |> Map.update!(:input_digits, fn _ -> "" end)
  end

  defp parse_input(""), do: 0

  defp parse_input(input_digits) do
    if String.contains?(input_digits, ".") do
      if String.last(input_digits) == "." do
        String.to_integer(String.slice(input_digits, 0..-2//1))
      else
        String.to_float(input_digits)
      end
    else
      String.to_integer(input_digits)
    end
  end
end
