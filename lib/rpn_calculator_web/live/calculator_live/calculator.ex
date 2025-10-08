defmodule RPNCalculatorWeb.CalculatorLive.Calculator do
  use RPNCalculatorWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <%!-- <.badge variant="solid" color="primary" size="xl" class="text-xl">
        <.icon name="hero-calculator" class="icon" /> RPN Calculator
      </.badge> --%>

      <div id="calculator" phx-window-keyup="calc-keyup" class="grid place-content-center">
        <div id="display">
          <div class="mb-1 w-72 text-right font-mono text-2xl bg-input p-2 rounded-lg text-foreground-softest">
            3
          </div>
          <div class="mb-1 w-72 text-right font-mono text-2xl bg-input p-2 rounded-lg text-foreground-softest">
            2
          </div>
          <div class="mb-1 w-72 text-right font-mono text-2xl bg-input p-2 rounded-lg text-foreground-softest">
            1
          </div>
          <div class="mb-4 w-72 text-right font-mono text-2xl bg-input p-2 rounded-lg">
            -3.14159
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

  defp animate_click(button_id) do
    JS.transition({"ease-out duration-300", "opacity-0", "opacity-100"}, time: 300, to: button_id)
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

  @impl true
  def handle_event("calc-keyup", %{"key" => key}, socket) do
    IO.inspect(key, label: "keyup")
    translated_key = Map.get(@key_translations, key, key)
    {:noreply, push_event(socket, "js-do", %{id: "button-#{translated_key}"})}
  end

  @impl true
  def handle_event("calc-button", %{"key" => key}, socket) do
    IO.inspect(key, label: "button")
    {:noreply, socket}
  end
end
