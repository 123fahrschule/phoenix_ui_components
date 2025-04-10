defmodule PhoenixUiComponents.DataTable do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Icon
  import PhoenixUiComponents.Icon

  attr :class, :string, default: nil
  attr :label, :string, required: true
  attr :active, :boolean, default: false
  attr :arrows, :boolean, default: false
  attr :rest, :global

  def data_table_label(assigns) do
    ~H"""
    <div
      class={[
        "flex items-center text-xs font-bold uppercase cursor-pointer px-2 py-1",
        get_active_classes(@active),
        @class
      ]}
      {@rest}
    >
      <%= @label %>
      <.icon :if={@arrows} icon={:sort} class="text-[16px]" />
    </div>
    """
  end

  defp get_active_classes(true), do: "bg-neutral-300 text-neutral-900 rounded-lg"
  defp get_active_classes(false), do: "bg-neutral-100 text-neutral-700"
end
