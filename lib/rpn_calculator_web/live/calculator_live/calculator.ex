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
              variant="solid"
              color="info"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="XY"
            >
              X <.icon name="hero-arrows-right-left" class="icon" />Y
            </.button>
            <.button
              variant="solid"
              color="info"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="RollDown"
            >
              R <.icon name="hero-arrow-down" class="icon" />
            </.button>
            <.button
              variant="solid"
              color="info"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="RollUp"
            >
              R <.icon name="hero-arrow-up" class="icon" />
            </.button>
            <.button
              variant="solid"
              color="info"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="Drop"
            >
              DROP
            </.button>
          </div>
          <div class="grid grid-cols-3 grid-rows-1 gap-4 justify-items-center w-72 font-bold mb-4">
            <.button
              variant="solid"
              color="danger"
              class="w-22"
              phx-click="calc-button"
              phx-value-key="Enter"
            >
              ENTER
            </.button>
            <.button
              variant="solid"
              color="success"
              class="w-22"
              phx-click="calc-button"
              phx-value-key="Clear"
            >
              CLEAR
            </.button>
            <.button
              variant="solid"
              color="success"
              class="w-22"
              phx-click="calc-button"
              phx-value-key="Backspace"
            >
              <.icon name="hero-backspace" class="icon" />
            </.button>
          </div>
          <div class="grid grid-cols-4 grid-rows-3 gap-4 justify-items-center w-72 font-bold">
            <.button
              variant="solid"
              color="primary"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="7"
            >
              7
            </.button>
            <.button
              variant="solid"
              color="primary"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="8"
            >
              8
            </.button>
            <.button
              variant="solid"
              color="primary"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="0"
            >
              9
            </.button>
            <.button
              variant="solid"
              color="warning"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="Divide"
            >
              ÷
            </.button>
            <.button
              variant="solid"
              color="primary"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="4"
            >
              4
            </.button>
            <.button
              variant="solid"
              color="primary"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="5"
            >
              5
            </.button>
            <.button
              variant="solid"
              color="primary"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="6"
            >
              6
            </.button>
            <.button
              variant="solid"
              color="warning"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="Multiply"
            >
              ×
            </.button>
            <.button
              variant="solid"
              color="primary"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="1"
            >
              1
            </.button>
            <.button
              variant="solid"
              color="primary"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="2"
            >
              2
            </.button>
            <.button
              variant="solid"
              color="primary"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="3"
            >
              3
            </.button>
            <.button
              variant="solid"
              color="warning"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="Subtract"
            >
              -
            </.button>
            <.button
              variant="solid"
              color="primary"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="0"
            >
              0
            </.button>
            <.button
              variant="solid"
              color="primary"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="."
            >
              .
            </.button>
            <.button
              variant="solid"
              color="primary"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="Sign"
            >
              + / -
            </.button>
            <.button
              variant="solid"
              color="warning"
              class="w-16"
              phx-click="calc-button"
              phx-value-key="Add"
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
  def handle_event("calc-keyup", %{"key" => key}, socket) do
    IO.inspect(key, label: "keyup")
    {:noreply, socket}
  end

  @impl true
  def handle_event("calc-button", %{"key" => key}, socket) do
    IO.inspect(key, label: "button")
    {:noreply, socket}
  end
end
