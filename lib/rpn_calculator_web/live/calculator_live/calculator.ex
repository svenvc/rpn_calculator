defmodule RPNCalculatorWeb.CalculatorLive.Calculator do
  use RPNCalculatorWeb, :live_view

  alias RPNCalculator.RPNCalculator

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div id="calculator" phx-window-keyup="calc-keyup" class="grid place-content-center">
        <div id="display" class="mb-3">
          <.calc_display soft>{render_stack_at(@rpn_calculator, 3)}</.calc_display>
          <.calc_display soft>{render_stack_at(@rpn_calculator, 2)}</.calc_display>
          <.calc_display soft>{render_stack_at(@rpn_calculator, 1)}</.calc_display>
          <.calc_display>{render_main_display(@rpn_calculator)}</.calc_display>
        </div>
        <div id="keypad">
          <div class="grid grid-cols-4 grid-rows-1 gap-4 justify-items-center w-72 font-bold mb-4">
            <.calc_button key="XY" color="info">
              X <.icon name="hero-arrows-right-left" class="icon" />Y
            </.calc_button>
            <.calc_button key="RollDown" color="info">
              R <.icon name="hero-arrow-down" class="icon" />
            </.calc_button>
            <.calc_button key="RollUp" color="info">
              R <.icon name="hero-arrow-up" class="icon" />
            </.calc_button>
            <.calc_button key="Drop" color="info">DROP</.calc_button>
          </div>
          <div class="grid grid-cols-3 grid-rows-1 gap-4 justify-items-center w-72 font-bold mb-4">
            <.calc_button key="Enter" color="danger" width="w-22">ENTER</.calc_button>
            <.calc_button key="Clear" color="success" width="w-22">CLEAR</.calc_button>
            <.calc_button key="Backspace" color="success" width="w-22">
              <.icon name="hero-backspace" class="icon" />
            </.calc_button>
          </div>
          <div class="grid grid-cols-4 grid-rows-3 gap-4 justify-items-center w-72 font-bold">
            <.calc_button key="7" />
            <.calc_button key="8" />
            <.calc_button key="9" />
            <.calc_button key="Divide" color="warning">&divide;</.calc_button>
            <.calc_button key="4" />
            <.calc_button key="5" />
            <.calc_button key="6" />
            <.calc_button key="Multiply" color="warning">&times;</.calc_button>
            <.calc_button key="1" />
            <.calc_button key="2" />
            <.calc_button key="3" />
            <.calc_button key="Subtract" color="warning">-</.calc_button>
            <.calc_button key="0" />
            <.calc_button key="Dot">&period;</.calc_button>
            <.calc_button key="Sign">+ / -</.calc_button>
            <.calc_button key="Add" color="warning">+</.calc_button>
          </div>
        </div>
      </div>
    </Layouts.app>
    """
  end

  attr :key, :string, required: true
  attr :color, :string, default: "primary"
  attr :width, :string, default: "w-16"
  slot :inner_block

  defp calc_button(assigns) do
    ~H"""
    <.button
      id={"button-#{@key}"}
      variant="solid"
      color={"#{@color}"}
      class={"active:bg-accent #{@width}"}
      phx-click="calc-button"
      phx-value-key={"#{@key}"}
      data-js-do={animate_click("#button-#{@key}")}
    >
      {render_slot(@inner_block) || @key}
    </.button>
    """
  end

  attr :soft, :boolean, default: false
  slot :inner_block, required: true

  defp calc_display(assigns) do
    ~H"""
    <div class={"#{"mb-1 w-72 min-h-12 text-right font-mono text-2xl bg-input p-2 rounded-lg"
                    <> (if @soft, do: " text-foreground-softest", else: "")}"}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, rpn_calculator: %RPNCalculator{})}
  end

  defp render_main_display(%RPNCalculator{} = rpn_calculator) do
    case rpn_calculator.input_digits do
      "" -> RPNCalculator.top_of_stack(rpn_calculator) |> to_string()
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
