defmodule PhoenixUiComponents.Dropdown do
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  @doc """
  Renders a dropdown component with customizable trigger and menu.

  ## Attributes

    * `id` (string, required): A unique identifier for the dropdown.
    * `trigger_class` (any, optional): CSS classes to apply to the default trigger button.
    * `menu_class` (any, optional): CSS classes to apply to the dropdown menu.
    * `placement` (string, optional): Position of the dropdown menu relative to the trigger.
      Defaults to "bottom".
    * `strategy` (string, optional): Positioning strategy for the dropdown menu.
      Defaults to "absolute".

  ## Slots

    * `inner_block`: Content to display in the default trigger button when no custom trigger is provided.
    * `trigger`: Optional custom trigger element to replace the default button.
    * `menu`: Dropdown menu content with an optional `close` function to programmatically close the dropdown.

  ## Examples

      # Basic dropdown
      <.dropdown id="user-menu">
        Open Menu
        <:menu>
          <.dropdown_item>Profile</dropdown_item>
          <.dropdown_item>Settings</dropdown_item>
        </:menu>
      </.dropdown>

      # Dropdown with custom trigger and placement
      <.dropdown id="options" placement="top-end">
        <:trigger>
          <button class="custom-button">Options</button>
        </:trigger>
        <:menu>
          <.dropdown_item>Option 1</dropdown_item>
          <.dropdown_item>Option 2</dropdown_item>
        </:menu>
      </.dropdown>
  """

  @placement [
    "top",
    "top-start",
    "top-end",
    "right",
    "right-start",
    "right-end",
    "bottom",
    "bottom-start",
    "bottom-end",
    "left",
    "left-start",
    "left-end"
  ]
  @strategy [
    "absolute",
    "fixed"
  ]

  attr(:id, :string, required: true)
  attr(:trigger_class, :any, default: nil)
  attr(:menu_class, :any, default: nil)
  attr(:placement, :string, values: @placement, default: "bottom")
  attr(:strategy, :string, values: @strategy, default: "absolute")

  slot(:inner_block)
  slot(:trigger)

  slot :menu do
    attr(:class, :any)
  end

  def dropdown(assigns) do
    ~H"""
    <div
      class="relative"
      data-dropdown
      phx-click={JS.show(to: {:inner, "[data-dropdown-menu]"})}
      data-hide={JS.hide(to: {:inner, "[data-dropdown-menu]"})}
    >
      <%= if @trigger == [] do %>
        <button class={@trigger_class}>
          {render_slot(@inner_block)}
        </button>
      <% else %>
        {render_slot(@trigger)}
      <% end %>

      <div
        id={"dropdown-menu-#{@id}"}
        phx-hook="DropdownMenu"
        class={[
          "dropdown-menu",
          @strategy,
          @menu_class
        ]}
        phx-click-away={JS.hide()}
        phx-window-keydown={JS.hide()}
        phx-key="Escape"
        data-dropdown-menu
        data-placement={@placement}
        data-strategy={@strategy}
      >
        {render_slot(@menu, %{close: JS.exec("data-hide", to: {:closest, "[data-dropdown]"})})}
      </div>
    </div>
    """
  end

  attr(:class, :any, default: nil)
  attr(:selected, :boolean, default: false)
  attr(:rest, :global)

  slot(:inner_block)

  def dropdown_item(assigns) do
    ~H"""
    <div
      class={["flex w-full hover:bg-neutral-200 rounded-lg", @selected && "bg-neutral-200 ", @class]}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
