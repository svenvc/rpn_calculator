defmodule RPNCalculatorWeb.CalculatorLive.Calculator do
  use RPNCalculatorWeb, :live_view

  alias RPNCalculator.RPNCalculator

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div id="calculator" phx-window-keyup="calc-keyup" class="grid place-content-center">
        <div id="display" class="mb-2">
          <.calc_display soft>{render_stack_at(@rpn_calculator, 3)}</.calc_display>
          <.calc_display soft>{render_stack_at(@rpn_calculator, 2)}</.calc_display>
          <.calc_display soft>{render_stack_at(@rpn_calculator, 1)}</.calc_display>
          <.calc_display>{render_main_display(@rpn_calculator)}</.calc_display>
        </div>
        <.alert :if={@error_msg} color="danger" hide_icon hide_close class="w-72 mb-2">
          {@error_msg}
        </.alert>
        <div id="keypad">
          <div class="grid grid-cols-4 grid-rows-1 gap-2 justify-items-center w-72 font-bold mb-2">
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
          <div class="grid grid-cols-4 grid-rows-1 gap-2 justify-items-center w-72 font-bold mb-2">
            <.calc_button key="Enter" color="danger">
              ENTER
            </.calc_button>
            <.calc_button key="Clear" color="success">
              CLEAR
            </.calc_button>
            <.tooltip
              value="Switch between basic and scientific calculator style"
              delay={1000}
              class="font-normal"
            >
              <.calc_button key="Style" color="success">
                <.icon name="hero-calculator" class="icon" />
              </.calc_button>
            </.tooltip>
            <.calc_button key="Backspace" color="success">
              <.icon name="hero-backspace" class="icon" />
            </.calc_button>
          </div>
          <div
            :if={!@basic_style}
            class="grid grid-cols-4 grid-rows-3 gap-2 justify-items-center w-72 font-bold mb-2"
          >
            <.calc_button key="Sin" color="warning">SIN</.calc_button>
            <.calc_button key="Cos" color="warning">COS</.calc_button>
            <.calc_button key="Tan" color="warning">TAN</.calc_button>
            <.calc_button key="Power" color="warning">x<sup>y</sup></.calc_button>
            <.calc_button key="ArcSin" color="warning">ASIN</.calc_button>
            <.calc_button key="ArcCos" color="warning">ACOS</.calc_button>
            <.calc_button key="ArcTan" color="warning">ATAN</.calc_button>
            <.calc_button key="Reciprocal" color="warning">1 / x</.calc_button>
            <.calc_button key="Square" color="warning">x<sup>2</sup></.calc_button>
            <.calc_button key="Sqrt" color="warning">&radic; x</.calc_button>
            <.calc_button key="Exp" color="warning">e<sup>x</sup></.calc_button>
            <.calc_button key="Ln" color="warning">LN</.calc_button>
            <.calc_button key="Log" color="warning">LOG</.calc_button>
            <.calc_button key="Pi" color="success">&#960;</.calc_button>
            <.calc_button key="E" color="success">e</.calc_button>
            <.calc_button key="EE" />
          </div>
          <div class="grid grid-cols-4 grid-rows-3 gap-2 justify-items-center w-72 font-bold">
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
          class="grid grid-cols-4 grid-rows-1 gap-4 justify-items-center w-72 mt-10"
        >
          <.tooltip value="How to use this calculator ?" delay={1000}>
            <.button
              variant="soft"
              size="xs"
              class="w-16"
              phx-click={Fluxon.open_dialog("sheet-help-instructions")}
            >
              Help
            </.button>
          </.tooltip>
          <.tooltip value="What are the keyboard key equivalents ?" delay={1000}>
            <.button
              variant="soft"
              size="xs"
              class="w-16"
              phx-click={Fluxon.open_dialog("sheet-keyboard-shortcuts")}
            >
              Keyboard
            </.button>
          </.tooltip>
          <.tooltip value="Show a log of all buttons that were pressed" delay={1000}>
            <.button
              variant="soft"
              size="xs"
              class="w-16"
              phx-click={Fluxon.open_dialog("sheet-key-log")}
            >
              Log
            </.button>
          </.tooltip>
          <.tooltip value="Show the state of the internal model of the calculator" delay={1000}>
            <.button
              variant="soft"
              size="xs"
              class="w-16"
              phx-click={Fluxon.open_dialog("sheet-internals")}
            >
              Internal
            </.button>
          </.tooltip>
        </div>
      </div>
    </Layouts.app>

    <.sheet_help_instructions />
    <.sheet_keyboard_shortcuts basic_style={@basic_style} />
    <.sheet_key_log key_log={@key_log} />
    <.sheet_internals rpn_calculator={@rpn_calculator} />
    """
  end

  defp sheet_help_instructions(assigns) do
    ~H"""
    <.sheet id="sheet-help-instructions" placement="top" class="min-h-48">
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
    """
  end

  attr :basic_style, :boolean, required: true

  defp sheet_keyboard_shortcuts(assigns) do
    ~H"""
    <.sheet id="sheet-keyboard-shortcuts" placement="left">
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
              <.calc_button key="XY" color="info" id_prefix="help-button">
                X <.icon name="hero-arrows-right-left" class="icon" />Y
              </.calc_button>
            </:cell>
            <:cell class="py-2">XY</:cell>
            <:cell class="py-2"><.button variant="outline">~</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="RollDown" color="info" id_prefix="help-button">
                R <.icon name="hero-arrow-down" class="icon" />
              </.calc_button>
            </:cell>
            <:cell class="py-2">RollDown</:cell>
            <:cell class="py-2"><.button variant="outline">ArrowDown</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="RollUp" color="info" id_prefix="help-button">
                R <.icon name="hero-arrow-up" class="icon" />
              </.calc_button>
            </:cell>
            <:cell class="py-2">RollUp</:cell>
            <:cell class="py-2"><.button variant="outline">ArrowUp</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Drop" color="info" id_prefix="help-button">
                DROP
              </.calc_button>
            </:cell>
            <:cell class="py-2">Drop</:cell>
            <:cell class="py-2"><.button variant="outline">d</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Enter" color="danger" id_prefix="help-button">
                ENTER
              </.calc_button>
            </:cell>
            <:cell class="py-2">Enter</:cell>
            <:cell class="py-2"><.button variant="outline">Enter</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Clear" color="success" id_prefix="help-button">
                CLEAR
              </.calc_button>
            </:cell>
            <:cell class="py-2">Clear</:cell>
            <:cell class="py-2"><.button variant="outline">c</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Backspace" color="success" id_prefix="help-button">
                <.icon name="hero-backspace" class="icon" />
              </.calc_button>
            </:cell>
            <:cell class="py-2">Backspace</:cell>
            <:cell class="py-2"><.button variant="outline">Backspace</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Add" color="warning" id_prefix="help-button">+</.calc_button>
            </:cell>
            <:cell class="py-2">Add</:cell>
            <:cell class="py-2"><.button variant="outline">+</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Subtract" color="warning" id_prefix="help-button">-</.calc_button>
            </:cell>
            <:cell class="py-2">Subtract</:cell>
            <:cell class="py-2"><.button variant="outline">-</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Multiply" color="warning" id_prefix="help-button">
                &times;
              </.calc_button>
            </:cell>
            <:cell class="py-2">Multiply</:cell>
            <:cell class="py-2"><.button variant="outline">*</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Divide" color="warning" id_prefix="help-button">
                &divide;
              </.calc_button>
            </:cell>
            <:cell class="py-2">Divide</:cell>
            <:cell class="py-2"><.button variant="outline">/</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Sign" id_prefix="help-button">+ / -</.calc_button>
            </:cell>
            <:cell class="py-2">Sign</:cell>
            <:cell class="py-2"><.button variant="outline">s</.button></:cell>
          </.table_row>
          <.table_row>
            <:cell class="py-2">
              <.calc_button key="Dot" id_prefix="help-button">&period;</.calc_button>
            </:cell>
            <:cell class="py-2">Dot</:cell>
            <:cell class="py-2"><.button variant="outline">.</.button></:cell>
          </.table_row>
          <.table_row :if={!@basic_style}>
            <:cell class="py-2">
              <.calc_button key="EE" id_prefix="help-button">EE</.calc_button>
            </:cell>
            <:cell class="py-2">EE</:cell>
            <:cell class="py-2"><.button variant="outline">e</.button></:cell>
          </.table_row>
          <.table_row :for={number <- 0..9}>
            <:cell class="py-2">
              <.calc_button key={"#{number}"} id_prefix="help-button">{number}</.calc_button>
            </:cell>
            <:cell class="py-2">{number}</:cell>
            <:cell class="py-2"><.button variant="outline">{number}</.button></:cell>
          </.table_row>
        </.table_body>
      </.table>
    </.sheet>
    """
  end

  attr :key_log, :list, required: true

  defp sheet_key_log(assigns) do
    ~H"""
    <.sheet id="sheet-key-log" placement="right">
      <.header>Last Operations Log</.header>
      <p class="mb-4">These are the last operations executed, most recent first.</p>
      <div class="w-96 max-w-fit">
        <.button :for={key <- @key_log} variant="outline" class="m-1">{key}</.button>
      </div>
    </.sheet>
    """
  end

  attr :rpn_calculator, :map, required: true

  defp sheet_internals(assigns) do
    ~H"""
    <.sheet id="sheet-internals" placement="top" class="min-h-48">
      <.header>Internal State</.header>
      <p>This is the representation of the RPN Calculator's internal state.</p>
      <div class="mt-4 whitespace-pre font-mono leading-10">{render_internals(@rpn_calculator)}</div>
    </.sheet>
    """
  end

  attr :key, :string, required: true
  attr :color, :string, default: "primary", values: ~w(primary danger warning success info)
  attr :width, :string, default: "w-16"
  attr :id_prefix, :string, default: "button"
  slot :inner_block

  defp calc_button(assigns) do
    ~H"""
    <.button
      id={"#{@id_prefix}-#{@key}"}
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

  defp render_main_display(%RPNCalculator{} = rpn_calculator) do
    case rpn_calculator.input_digits do
      "" -> RPNCalculator.top_of_stack(rpn_calculator) |> RPNCalculator.render_number()
      _ -> rpn_calculator.input_digits
    end
  end

  defp render_stack_at(%RPNCalculator{} = rpn_calculator, level) do
    if Enum.count(rpn_calculator.rpn_stack) > level do
      rpn_calculator.rpn_stack |> Enum.at(level) |> RPNCalculator.render_number()
    else
      ""
    end
  end

  defp render_internals(rpn_calculator) do
    inspect(
      rpn_calculator |> Map.take([:rpn_stack, :input_digits, :computed?]),
      pretty: true
    )
  end

  defp animate_click(button_id) do
    JS.transition(
      {"ease-out duration-200", "opacity-0", "opacity-100"},
      time: 200,
      to: button_id
    )
  end

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(rpn_calculator: %RPNCalculator{})
      |> assign(key_log: [])
      |> assign(basic_style: true)
      |> assign(error_msg: nil)

    {:ok, socket}
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
    "d" => "Drop",
    "e" => "EE"
  }

  @impl true
  def handle_event("calc-keyup", %{"key" => key}, socket) do
    # IO.inspect(key, label: "keyup")
    translated_key = Map.get(@key_translations, key, key)

    if translated_key in RPNCalculator.known_keys() do
      {:noreply,
       socket
       |> process_key(translated_key)
       |> push_event("js-do", %{id: "button-#{translated_key}"})}
    else
      {:noreply, socket}
    end
  end

  @impl true
  def handle_event("calc-button", %{"key" => "Style"}, socket) do
    # IO.inspect(key, label: "button")
    {:noreply, assign(socket, basic_style: !socket.assigns.basic_style)}
  end

  @impl true
  def handle_event("calc-button", %{"key" => key}, socket) do
    # IO.inspect(key, label: "button")
    {:noreply, socket |> process_key(key)}
  end

  defp process_key(socket, key) do
    # IO.inspect(key, label: "processing")
    if key in RPNCalculator.known_keys() do
      try do
        rpn_calculator = socket.assigns.rpn_calculator |> RPNCalculator.process_key(key)
        # IO.inspect(rpn_calculator, label: "rpn_calculator")
        socket
        |> assign(rpn_calculator: rpn_calculator)
        |> assign(key_log: [key | socket.assigns.key_log])
        |> assign(error_msg: nil)
      rescue
        e -> socket |> assign(error_msg: Exception.message(e))
      end
    else
      socket
    end
  end
end
