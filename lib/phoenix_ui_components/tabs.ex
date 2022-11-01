defmodule PhoenixUiComponents.Tabs do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Button
  import PhoenixUiComponents.Icon

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
  attr(:rest, :global)

  slot(:inner_block, required: true)

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

  defp get_active_classes(true),
    do:
      "font-bold after:border-t-2 after:absolute after:bottom-0 after:left-0 after:w-full after:border-neutral-900 after:rounded-t-[3px]"

  defp get_active_classes(_), do: nil
end
