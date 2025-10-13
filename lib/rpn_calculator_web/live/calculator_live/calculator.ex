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
            <.calc_button key="Drop" color="info">
              DROP
            </.calc_button>
          </div>
          <div class="grid grid-cols-3 grid-rows-1 gap-4 justify-items-center w-72 font-bold mb-4">
            <.calc_button key="Enter" color="danger" width="w-22">
              ENTER
            </.calc_button>
            <.calc_button key="Clear" color="success" width="w-22">
              CLEAR
            </.calc_button>
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
        <div
          id="help-panel"
          class="grid grid-cols-4 grid-rows-1 gap-4 justify-items-center w-72 mt-16"
        >
          <.button variant="soft" size="xs" class="w-16" phx-click={Fluxon.open_dialog("sheet-help")}>
            Help
          </.button>
          <.button variant="soft" size="xs" class="w-16" phx-click={Fluxon.open_dialog("sheet-keyboard")}
          >
            Keyboard
          </.button>
          <.button variant="soft" size="xs" class="w-16" phx-click={Fluxon.open_dialog("sheet-log")}>
            Log
          </.button>
          <.button variant="soft" size="xs" class="w-16" phx-click={Fluxon.open_dialog("sheet-internal")}
          >
            Internal
          </.button>
        </div>
      </div>
    </Layouts.app>

    <.sheet id="sheet-help" placement="top" class="min-h-48">
      <.header>Help</.header>
      <div class="space-y-4 w-128 max-w-fit">
        <p>
          This calculator uses Reverse Polish Notation (RPN).
          That means that you first push numbers on a stack and then you select the operation to perform.
        </p>
        <p>
          For example, to compute <b>(100 + 200) / 3</b>, you would type <b>100</b>, <b>Enter</b>
          (to push the current number up the stack), <b>200</b>
          (the stack now contains 100 and 200), <b>+</b>
          (to add the top two stack entries, often called x and y, together,
          remove them and leave the result on the top of the stack), <b>3</b>
          and finally <b>/</b>
          (to divide x by y).
          Note how you no longer need parenthesis, nor an equal sign.
          Even a memory register is not really necessary.
        </p>
        <p>
          Additionally, there are a number of stack manipulation operations, such as
          switching x and y, dropping x and rolling the stack downwards or upwards.
          The display shows the top 4 stack positions.
        </p>
      </div>
    </.sheet>

    <.sheet id="sheet-keyboard" placement="left">
      <.header>Keyboard Shortcuts</.header>
      <.table>
        <.table_head>
          <:col class="py-2">Button</:col>
          <:col class="py-2">Operation</:col>
          <:col class="py-2">Shortcut</:col>
        </.table_head>
        <.table_body>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="XY" color="info">
                X <.icon name="hero-arrows-right-left" class="icon" />Y
              </.calc_button>
            </:cell>
            <:cell class="py-2">XY</:cell>
            <:cell class="py-2"><.button variant="outline">~</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="RollDown" color="info">
                R <.icon name="hero-arrow-down" class="icon" />
              </.calc_button>
            </:cell>
            <:cell class="py-2">RollDown</:cell>
            <:cell class="py-2"><.button variant="outline">ArrowDown</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="RollUp" color="info">
                R <.icon name="hero-arrow-up" class="icon" />
              </.calc_button>
            </:cell>
            <:cell class="py-2">RollUp</:cell>
            <:cell class="py-2"><.button variant="outline">ArrowUp</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Drop" color="info">
                DROP
              </.calc_button>
            </:cell>
            <:cell class="py-2">Drop</:cell>
            <:cell class="py-2"><.button variant="outline">d</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Enter" color="danger" width="w-22">
                ENTER
              </.calc_button>
            </:cell>
            <:cell class="py-2">Enter</:cell>
            <:cell class="py-2"><.button variant="outline">Enter</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Clear" color="success" width="w-22">
                CLEAR
              </.calc_button>
            </:cell>
            <:cell class="py-2">Clear</:cell>
            <:cell class="py-2"><.button variant="outline">c</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Backspace" color="success" width="w-22">
                <.icon name="hero-backspace" class="icon" />
              </.calc_button>
            </:cell>
            <:cell class="py-2">Backspace</:cell>
            <:cell class="py-2"><.button variant="outline">Backspace</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Add" color="warning">+</.calc_button>
            </:cell>
            <:cell class="py-2">Add</:cell>
            <:cell class="py-2"><.button variant="outline">+</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Subtract" color="warning">-</.calc_button>
            </:cell>
            <:cell class="py-2">Subtract</:cell>
            <:cell class="py-2"><.button variant="outline">-</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Multiply" color="warning">&times;</.calc_button>
            </:cell>
            <:cell class="py-2">Multiply</:cell>
            <:cell class="py-2"><.button variant="outline">*</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Divide" color="warning">&divide;</.calc_button>
            </:cell>
            <:cell class="py-2">Divide</:cell>
            <:cell class="py-2"><.button variant="outline">/</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Sign">+ / -</.calc_button>
            </:cell>
            <:cell class="py-2">Sign</:cell>
            <:cell class="py-2"><.button variant="outline">s</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Dot">&period;</.calc_button>
            </:cell>
            <:cell class="py-2">Dot</:cell>
            <:cell class="py-2"><.button variant="outline">.</.button></:cell>
          </.table_row>
          <.table_row :for={number <- 0..9}>
            <:cell class="py-2">
              <.calc_button key={"#{number}"}>{number}</.calc_button>
            </:cell>
            <:cell class="py-2">{number}</:cell>
            <:cell class="py-2"><.button variant="outline">{number}</.button></:cell>
          </.table_row>
        </.table_body>
      </.table>
    </.sheet>

    <.sheet id="sheet-log" placement="right">
      <.header>Last Operations Log</.header>
      <p class="mb-4">These are the last operations executed, most recent first.</p>
      <div class="w-96 max-w-fit">
        <.button :for={key <- @key_log} variant="outline" class="m-1">{key}</.button>
      </div>
    </.sheet>

    <.sheet id="sheet-internal" placement="top" class="min-h-48">
      <.header>Internal State</.header>
      <p>This is the representation of the RPN Calculator's internal state.</p>
      <div class="mt-4 whitespace-pre font-mono leading-10">{inspect(@rpn_calculator |> Map.take([:rpn_stack, :input_digits, :computed?]), pretty: true)}</div>
    </.sheet>
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
    {:ok, assign(socket, rpn_calculator: %RPNCalculator{}, key_log: [])}
  end

  defp render_main_display(%RPNCalculator{} = rpn_calculator) do
    case rpn_calculator.input_digits do
      "" -> RPNCalculator.top_of_stack(rpn_calculator) |> render_number()
      _ -> rpn_calculator.input_digits
    end
  end

  defp render_stack_at(%RPNCalculator{} = rpn_calculator, level) do
    if Enum.count(rpn_calculator.rpn_stack) > level do
      rpn_calculator.rpn_stack |> Enum.at(level) |> render_number()
    else
      ""
    end
  end

  defp render_number(number) do
    integer = trunc(number)
    to_string(if number == integer, do: integer, else: number)
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
    # IO.inspect(key, label: "keyup")
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
    # IO.inspect(key, label: "button")
    {:noreply, socket |> process_key(key)}
  end

  defp process_key(socket, key) when key in @allowed_keys do
    # IO.inspect(key, label: "processing")
    rpn_calculator = socket.assigns.rpn_calculator |> RPNCalculator.process_key(key)
    # IO.inspect(rpn_calculator, label: "rpn_calculator")
    assign(socket, rpn_calculator: rpn_calculator, key_log: [key | socket.assigns.key_log])
  end
end
