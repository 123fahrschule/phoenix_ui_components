defmodule PhoenixUiComponents.TopNav do
  use PhoenixUiComponents, :component

  def top_nav_container(assigns) do
    assigns =
      assigns
      |> assign_class()
      |> assign_slot(:user_section)
      |> assign_slot(:inner_block)
      |> assign_rest()

    ~H"""
    <div class={["h-16 border-b border-b-neutral-300 flex items-center", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  def sunrise_sunset(assigns) do
    assigns =
      assigns
      |> assign_class()

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
