defmodule PhoenixUiComponents.Badge do
  use PhoenixUiComponents, :component

  attr(:class, :string, default: nil)
  attr(:label, :string, default: nil)
  attr(:size, :string, values: ["sm", "md"], default: "md")

  attr(:type, :string,
    values: ["neutral", "success", "error", "info", "warning"],
    default: "neutral"
  )

  attr(:icon, :atom, default: nil)
  attr(:icon_position, :string, values: ["start", "end"], default: "start")
  attr(:rest, :global)

  def badge(%{icon: nil} = assigns) do
    ~H"""
    <div class={[get_classes(assigns), get_size_classes(@size, @label)]} {@rest}>
      <%= @label %>
    </div>
    """
  end

  def badge(%{label: nil} = assigns) do
    ~H"""
    <div class={[get_classes(assigns), get_size_classes(@size, @label)]} {@rest}>
      <MaterialIcons.icon icon={@icon} class="text-[24px]" />
    </div>
    """
  end

  def badge(assigns) do
    ~H"""
    <div class={[get_classes(assigns), get_size_classes(@size, @label)]} {@rest}>
      <MaterialIcons.icon
        :if={@icon_position == "start"}
        icon={@icon}
        class="text-[16px] -ml-2 mr-0.5"
      />
      <%= @label %>
      <MaterialIcons.icon :if={@icon_position == "end"} icon={@icon} class="text-[16px] -mr-2 ml-0.5" />
    </div>
    """
  end

  defp get_classes(%{type: type}) do
    [
      "rounded-full text-sm font-semibold hover:shadow-sm-3 inline-flex items-center cursor-pointer align-middle",
      get_color_classes(type)
    ]
  end

  defp get_size_classes("sm", label) do
    if label, do: "py-0.5 px-3", else: "p-1"
  end

  defp get_size_classes("md", label) do
    if label, do: "py-1.5 px-4", else: "p-1"
  end

  defp get_color_classes("neutral"), do: "bg-neutral-300 text-neutral-700"
  defp get_color_classes("success"), do: "bg-success-100 text-success-400"
  defp get_color_classes("error"), do: "bg-error-100 text-error-400"
  defp get_color_classes("info"), do: "bg-info-100 text-info-400"
  defp get_color_classes("warning"), do: "bg-warning-100 text-warning-500"
end
