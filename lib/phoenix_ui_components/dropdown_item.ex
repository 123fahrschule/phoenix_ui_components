defmodule PhoenixUiComponents.DropdownItem do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Icon

  attr :class, :any, default: nil
  attr :label, :string, default: nil
  attr :selected, :boolean, default: false
  attr :size, :string, values: ["sm", "md", "lg"], default: "md"
  attr :check_icon_position, :string, values: ["left", "right"], default: "left"

  slot :inner_block

  def dropdown_item(assigns) do
    ~H"""
    <div class={["relative flex items-baseline", @class]}>
      <.icon
        :if={@selected && @check_icon_position == "left"}
        icon={:check}
        class={list_class_value(["mr-2", get_icon_size_classes(@size)])}
      />
      <%= if @label, do: @label, else: render_slot(@inner_block) %>
      <.icon
        :if={@selected && @check_icon_position == "right"}
        icon={:check}
        class={list_class_value(["ml-2", get_icon_size_classes(@size)])}
      />
    </div>
    """
  end

  # defp get_size_classes("sm"), do: "text-xs"
  # defp get_size_classes("md"), do: "text-sm"
  # defp get_size_classes("lg"), do: "text-base"

  defp get_icon_size_classes("lg"), do: "text-[24px]"
  defp get_icon_size_classes(_), do: "text-[16px]"
end
