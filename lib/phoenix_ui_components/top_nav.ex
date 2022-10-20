defmodule PhoenixUiComponents.TopNav do
  use PhoenixUiComponents, :component

  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, default: [])

  def top_nav_container(assigns) do
    ~H"""
    <div class={["h-16 border-b border-b-neutral-300 flex items-center", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :string, default: nil)
  attr(:sunrise, :string, required: true)
  attr(:sunset, :string, required: true)

  def sunrise_sunset(assigns) do
    ~H"""
    <div class={["flex space-x-2 text-xs text-gray-500", @class]}>
      <div>
        <MaterialIcons.icon icon={:wb_sunny} class="text-[16px] text-warning-300 align-middle" />
        <span>
          <%= @sunset %>
        </span>
      </div>
      <div>
        <MaterialIcons.icon icon={:dark_mode} class="text-[16px] text-info-500 align-middle" />
        <span>
          <%= @sunrise %>
        </span>
      </div>
    </div>
    """
  end
end
