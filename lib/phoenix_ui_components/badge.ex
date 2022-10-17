defmodule PhoenixUiComponents.Badge do
  use PhoenixUiComponents, :component

  # attr :class :string, default: nil
  # attr :label, :string, default: nil
  # attr :size, :string, default: "md", values: ["sm", "md"]
  # attr :type, :string, default: "neutral", values: ["neutral", "success", "error", "info", "warning"]
  # attr :icon, :atom, default: nil
  # attr :icon_position, :string, default: 'start', values: ["start", "end"]
  # attr :rest, :global
  def badge(assigns) do
    assigns =
      assigns
      |> assign_class()
      |> assign_attr(:label)
      |> assign_attr(:size, "md")
      |> assign_attr(:type, "neutral")
      |> assign_attr(:icon)
      |> assign_attr(:icon_position, "start")
      |> assign_rest([:label, :size, :type, :icon, :icon_position])

    ~H"""
    <div
      class={
        [
          "rounded-full text-sm font-semibold hover:shadow-sm-3 inline-flex items-center cursor-pointer align-middle",
          get_size_classes(@size, @label),
          get_color_classes(@type),
          @class
        ]
      }
      {@rest}
    >
      <.content {assigns} />
    </div>
    """
  end

  defp content(%{icon: icon} = assigns) when is_nil(icon) do
    ~H"""
    <%= @label %>
    """
  end

  defp content(%{label: label} = assigns) when is_nil(label) do
    ~H"""
    <MaterialIcons.icon icon={@icon} class="text-[24px]" />
    """
  end

  defp content(assigns) do
    ~H"""
    <%= if @icon_position == "start" do %>
      <MaterialIcons.icon icon={@icon} class="text-[16px] -ml-2 mr-0.5" />
    <% end %>
    <%= @label %>
    <%= if @icon_position == "end" do %>
      <MaterialIcons.icon icon={@icon} class="text-[16px] -mr-2 ml-0.5" />
    <% end %>
    """
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
