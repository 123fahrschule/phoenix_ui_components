defmodule PhoenixUiComponents.Checkbox do
  use PhoenixUiComponents, :component
  use PhoenixHTMLHelpers

  import Phoenix.HTML.Form

  attr :form, :any, required: true
  attr :field, :atom, required: true
  attr :label, :string, default: nil
  attr :class, :string, default: nil
  attr :size, :string, values: ["sm", "md", "lg"], default: "md"

  slot :inner_block

  def checkbox(assigns) do
    ~H"""
    <div class={["relative flex items-center px-2", get_size_classes(@size), @class]}>
      <%= checkbox(@form, @field,
        class: [
          "peer rounded border-2 border-neutral-700 text-primary-300 focus:ring-primary-300 mr-2 cursor-pointer",
          get_checkbox_size_classes(@size)
        ]
      ) %>
      <label
        for={input_id(@form, @field)}
        class="cursor-pointer text-neutral-700 peer-checked:font-semibold peer-checked:text-neutral-900"
      >
        <%= if @label, do: @label, else: render_slot(@inner_block) %>
      </label>
    </div>
    """
  end

  defp get_size_classes("sm"), do: "text-xs py-3"
  defp get_size_classes("md"), do: "text-sm py-4"
  defp get_size_classes("lg"), do: "text-base py-4"

  defp get_checkbox_size_classes("sm"), do: "h-4 w-4"
  defp get_checkbox_size_classes("md"), do: "h-4 w-4"
  defp get_checkbox_size_classes("lg"), do: "h-6 w-6"
end
