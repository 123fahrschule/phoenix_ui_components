defmodule PhoenixUiComponents.Banner do
  use PhoenixUiComponents, :component

  attr(:class, :string, default: nil)
  attr(:type, :string, values: ["info", "success", "warning", "error"], default: "info")
  attr(:size, :string, values: ["sm", "md", "lg"], default: "md")
  attr(:message, :string, required: true)
  attr(:label, :string, default: nil)
  attr(:close_button_attributes, :any, default: nil)
  attr(:rest, :global)

  def banner(assigns) do
    ~H"""
    <div
      role="alert"
      class={[
        "rounded-lg flex items-center",
        get_color_classes(@type),
        get_size_classes(@size),
        @class
      ]}
      {@rest}
    >
      <div class={[
        "rounded-lg mr-2 flex items-center justify-center",
        get_icon_container_color_classes(@type),
        get_icon_container_size_classes(@size)
      ]}>
        <MaterialIcons.icon
          icon={get_icon(@type)}
          class={["text-white ", get_icon_size_classes(@size)]}
        />
      </div>
      <div class="mr-2">
        <p :if={@label} class="font-bold">
          <%= @label %>
        </p>
        <p class="text-neutral-900">
          <%= @message %>
        </p>
      </div>
      <button
        :if={@close_button_attributes}
        class={[
          "p-2 ml-auto rounded-full flex items-center content-center",
          get_close_icon_color_classes(@type)
        ]}
        {@close_button_attributes}
      >
        <MaterialIcons.icon icon={:close} class="text-[16px]" />
      </button>
    </div>
    """
  end

  defp get_size_classes("sm"), do: "p-2 text-xs leading-[1.334]"
  defp get_size_classes("md"), do: "p-2 text-sm leading-[1.429]"
  defp get_size_classes("lg"), do: "p-3 text-sm leading-[1.429]"

  defp get_color_classes("info"), do: "bg-info-100 text-info-400"
  defp get_color_classes("success"), do: "bg-success-100 text-success-300"
  defp get_color_classes("warning"), do: "bg-warning-100 text-warning-300"
  defp get_color_classes("error"), do: "bg-error-100 text-error-300"

  defp get_icon_container_size_classes("sm"), do: "w-6 h-6 p-1 text-base"
  defp get_icon_container_size_classes("md"), do: "w-8 h-8 p-1 text-2xl"
  defp get_icon_container_size_classes("lg"), do: "w-10 h-10 p-2 text-2xl"

  defp get_icon_size_classes("sm"), do: "text-[16px]"
  defp get_icon_size_classes(_), do: "text-[24px]"

  defp get_icon_container_color_classes("info"), do: "bg-info-400"
  defp get_icon_container_color_classes("success"), do: "bg-success-300"
  defp get_icon_container_color_classes("warning"), do: "bg-warning-300"
  defp get_icon_container_color_classes("error"), do: "bg-error-300"

  defp get_close_icon_color_classes("info"), do: "text-info-400"
  defp get_close_icon_color_classes("success"), do: "text-success-300"
  defp get_close_icon_color_classes("warning"), do: "text-warning-300"
  defp get_close_icon_color_classes("error"), do: "text-error-300"

  defp get_icon("info"), do: :info
  defp get_icon("success"), do: :check_circle
  defp get_icon("warning"), do: :warning
  defp get_icon("error"), do: :error
end
