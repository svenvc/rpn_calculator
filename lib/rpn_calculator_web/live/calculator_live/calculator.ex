defmodule RPNCalculatorWeb.CalculatorLive.Calculator do
  use RPNCalculatorWeb, :live_view

  alias RPNCalculator.RPNCalculator

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <%!-- <.badge variant="solid" color="primary" size="xl" class="text-xl">
        <.icon name="hero-calculator" class="icon" /> RPN Calculator
      </.badge> --%>

      <div id="calculator" phx-window-keyup="calc-keyup" class="grid place-content-center">
        <div id="display">
          <div class="mb-1 w-72 min-h-12 text-right font-mono text-2xl bg-input p-2 rounded-lg text-foreground-softest">
            {render_stack_at(@rpn_calculator, 3)}
          </div>
          <div class="mb-1 w-72 min-h-12 text-right font-mono text-2xl bg-input p-2 rounded-lg text-foreground-softest">
            {render_stack_at(@rpn_calculator, 2)}
          </div>
          <div class="mb-1 w-72 min-h-12 text-right font-mono text-2xl bg-input p-2 rounded-lg text-foreground-softest">
            {render_stack_at(@rpn_calculator, 1)}
          </div>
          <div class="mb-4 w-72 text-right font-mono text-2xl bg-input p-2 rounded-lg">
            {render_main_display(@rpn_calculator)}
          </div>
        </div>
        <div id="keypad">
          <div class="grid grid-cols-4 grid-rows-1 gap-4 justify-items-center w-72 font-bold mb-4">
            <.button
              id="button-XY"
              variant="solid"
              color="info"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="XY"
              data-js-do={animate_click("#button-XY")}
            >
              X <.icon name="hero-arrows-right-left" class="icon" />Y
            </.button>
            <.button
              id="button-RollDown"
              variant="solid"
              color="info"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="RollDown"
              data-js-do={animate_click("#button-RollDown")}
            >
              R <.icon name="hero-arrow-down" class="icon" />
            </.button>
            <.button
              id="button-RollUp"
              variant="solid"
              color="info"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="RollUp"
              data-js-do={animate_click("#button-RollUp")}
            >
              R <.icon name="hero-arrow-up" class="icon" />
            </.button>
            <.button
              id="button-Drop"
              variant="solid"
              color="info"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="Drop"
              data-js-do={animate_click("#button-Drop")}
            >
              DROP
            </.button>
          </div>
          <div class="grid grid-cols-3 grid-rows-1 gap-4 justify-items-center w-72 font-bold mb-4">
            <.button
              id="button-Enter"
              variant="solid"
              color="danger"
              class="active:bg-accent w-22"
              phx-click="calc-button"
              phx-value-key="Enter"
              data-js-do={animate_click("#button-Enter")}
            >
              ENTER
            </.button>
            <.button
              id="button-Clear"
              variant="solid"
              color="success"
              class="active:bg-accent w-22"
              phx-click="calc-button"
              phx-value-key="Clear"
              data-js-do={animate_click("#button-Clear")}
            >
              CLEAR
            </.button>
            <.button
              id="button-Backspace"
              variant="solid"
              color="success"
              class="active:bg-accent w-22"
              phx-click="calc-button"
              phx-value-key="Backspace"
              data-js-do={animate_click("#button-Backspace")}
            >
              <.icon name="hero-backspace" class="icon" />
            </.button>
          </div>
          <div class="grid grid-cols-4 grid-rows-3 gap-4 justify-items-center w-72 font-bold">
            <.button
              id="button-7"
              variant="solid"
              color="primary"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="7"
              data-js-do={animate_click("#button-7")}
            >
              7
            </.button>
            <.button
              id="button-8"
              variant="solid"
              color="primary"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="8"
              data-js-do={animate_click("#button-8")}
            >
              8
            </.button>
            <.button
              id="button-9"
              variant="solid"
              color="primary"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="9"
              data-js-do={animate_click("#button-9")}
            >
              9
            </.button>
            <.button
              id="button-Divide"
              variant="solid"
              color="warning"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="Divide"
              data-js-do={animate_click("#button-Divide")}
            >
              ÷
            </.button>
            <.button
              id="button-4"
              variant="solid"
              color="primary"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="4"
              data-js-do={animate_click("#button-4")}
            >
              4
            </.button>
            <.button
              id="button-5"
              variant="solid"
              color="primary"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="5"
              data-js-do={animate_click("#button-5")}
            >
              5
            </.button>
            <.button
              id="button-6"
              variant="solid"
              color="primary"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="6"
              data-js-do={animate_click("#button-6")}
            >
              6
            </.button>
            <.button
              id="button-Multiply"
              variant="solid"
              color="warning"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="Multiply"
              data-js-do={animate_click("#button-Multiply")}
            >
              ×
            </.button>
            <.button
              id="button-1"
              variant="solid"
              color="primary"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="1"
              data-js-do={animate_click("#button-1")}
            >
              1
            </.button>
            <.button
              id="button-2"
              variant="solid"
              color="primary"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="2"
              data-js-do={animate_click("#button-2")}
            >
              2
            </.button>
            <.button
              id="button-3"
              variant="solid"
              color="primary"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="3"
              data-js-do={animate_click("#button-3")}
            >
              3
            </.button>
            <.button
              id="button-Subtract"
              variant="solid"
              color="warning"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="Subtract"
              data-js-do={animate_click("#button-Subtract")}
            >
              -
            </.button>
            <.button
              id="button-0"
              variant="solid"
              color="primary"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="0"
              data-js-do={animate_click("#button-0")}
            >
              0
            </.button>
            <.button
              id="button-Dot"
              variant="solid"
              color="primary"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="Dot"
              data-js-do={animate_click("#button-Dot")}
            >
              .
            </.button>
            <.button
              id="button-Sign"
              variant="solid"
              color="primary"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="Sign"
              data-js-do={animate_click("#button-Sign")}
            >
              + / -
            </.button>
            <.button
              id="button-Add"
              variant="solid"
              color="warning"
              class="active:bg-accent w-16"
              phx-click="calc-button"
              phx-value-key="Add"
              data-js-do={animate_click("#button-Add")}
            >
              +
            </.button>
          </div>
        </div>
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, rpn_calculator: %RPNCalculator{})}
  end

  defp render_main_display(%RPNCalculator{} = rpn_calculator) do
    case rpn_calculator.input_digits do
      "" -> rpn_calculator.rpn_stack |> List.first() |> to_string()
      _ -> rpn_calculator.input_digits
    end
  end

  defp render_stack_at(%RPNCalculator{} = rpn_calculator, level) do
    if Enum.count(rpn_calculator.rpn_stack) > level do
      rpn_calculator.rpn_stack |> Enum.at(level) |> to_string()
    else
      ""
    end
  end

  defp animate_click(button_id) do
    JS.transition(
      {"ease-out duration-200", "opacity-0", "opacity-100"},
      time: 200,
      to: button_id
    )
  end

  @key_translations %{
    "+" => "Add",
    "-" => "Subtract",
    "*" => "Multiply",
    "/" => "Divide",
    "s" => "Sign",
    "c" => "Clear",
    "." => "Dot",
    "~" => "XY",
    "ArrowDown" => "RollDown",
    "ArrowUp" => "RollUp",
    "d" => "Drop"
  }

  @allowed_keys [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "Add",
    "Subtract",
    "Multiply",
    "Divide",
    "Dot",
    "Sign",
    "Enter",
    "Clear",
    "Backspace",
    "XY",
    "RollDown",
    "RollUp",
    "Drop"
  ]

  @impl true
  def handle_event("calc-keyup", %{"key" => key}, socket) do
    IO.inspect(key, label: "keyup")
    translated_key = Map.get(@key_translations, key, key)

    if translated_key in @allowed_keys do
      {:noreply,
       socket
       |> process_key(translated_key)
       |> push_event("js-do", %{id: "button-#{translated_key}"})}
    else
      {:noreply, socket}
    end
  end

  @impl true
  def handle_event("calc-button", %{"key" => key}, socket) do
    IO.inspect(key, label: "button")
    {:noreply, socket |> process_key(key)}
  end

  defp process_key(socket, key) when key in @allowed_keys do
    IO.inspect(key, label: "processing")
    rpn_calculator = socket.assigns.rpn_calculator |> RPNCalculator.process_key(key)
    IO.inspect(rpn_calculator, label: "rpn_calculator")
    assign(socket, :rpn_calculator, rpn_calculator)
  end
end
