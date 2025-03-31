defmodule PhoenixUiComponents.Tabs do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Icon
  alias Phoenix.LiveView.JS

  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, required: true)

  def tabs(assigns) do
    ~H"""
    <div class={["flex", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :string, default: nil)
  attr(:label, :string, default: nil)
  attr(:active, :boolean, default: false)
  attr(:icon, :atom, default: nil)
  attr(:target, :string, default: nil)
  attr(:group, :string, default: "tabs")
  attr(:rest, :global)

  slot(:inner_block)

  def tab(%{target: target} = assigns) when not is_nil(target) do
    ~H"""
    <button
      phx-mounted={@active && set_active_tab(@target, @group)}
      phx-click={set_active_tab(@target, @group)}
      class={["px-4 py-2 text-sm flex items-center relative", get_active_classes(@active), @class]}
      data-tab={@group}
      {@rest}
    >
      <.icon :if={@icon} outlined icon={@icon} class="text-[16px] mr-1" />
      <%= if @label, do: @label, else: render_slot(@inner_block) %>
    </button>
    """
  end

  def tab(assigns) do
    ~H"""
    <button
      class={["px-4 py-2 text-sm flex items-center relative", get_active_classes(@active), @class]}
      {@rest}
    >
      <.icon :if={@icon} outlined icon={@icon} class="text-[16px] mr-1" />
      <%= if @label, do: @label, else: render_slot(@inner_block) %>
    </button>
    """
  end

  attr(:class, :string, default: nil)
  attr(:id, :string, required: true)
  attr(:group, :string, default: "tabs")
  attr(:rest, :global)

  slot(:inner_block, required: true)

  def tab_content(assigns) do
    ~H"""
    <div id={@id} class={["hidden", @class]} data-tab-content={@group} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  defp active_classes(),
    do:
      "font-bold after:border-t-2 after:absolute after:bottom-0 after:left-0 after:w-full after:border-neutral-900 after:rounded-t-[3px]"

  defp get_active_classes(true), do: active_classes()

  defp get_active_classes(false), do: nil

  defp set_active_tab(js \\ %JS{}, target, group) do
    js
    |> JS.remove_class(active_classes(), to: "[data-tab='#{group}']")
    |> JS.add_class(active_classes())
    |> JS.hide(to: "[data-tab-content='#{group}']")
    |> JS.show(to: target)
  end
end
