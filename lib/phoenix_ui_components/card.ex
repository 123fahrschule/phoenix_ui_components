defmodule PhoenixUiComponents.Card do
  use PhoenixUiComponents, :component

  # attr :class :string, default: nil
  # attr :rounded :string, default: "md", values: ["xs", "sm", "md", "lg", "xl"]
  # attr :shadow :string, default: "md", values: ["sm", "sm-2", "sm-3", "sm-4", "md", "md-2", "md-3", "md-4", "lg", "lg-2", "lg-3", "lg-4"]
  # attr :border :boolean, default: false
  # attr :background :string, default: "white", values: ["white", "neutral"]
  # attr :rest, :global
  # slot :inner_block, required: true
  def card(assigns) do
    assigns =
      assigns
      |> assign_class()
      |> assign_attr(:rounded, "md")
      |> assign_attr(:shadow, "md")
      |> assign_attr(:border, false)
      |> assign_attr(:background, "white")
      |> assign_rest([:rounded, :shadow, :border])

    ~H"""
    <div
      class={
        [
          get_border_radius_classes(@rounded),
          get_shadow_classes(@shadow),
          get_border_classes(@border),
          @class
        ]
      }
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  defp get_border_radius_classes("xs"), do: "rounded"
  defp get_border_radius_classes("sm"), do: "rounded-lg"
  defp get_border_radius_classes("md"), do: "rounded-2xl"
  defp get_border_radius_classes("lg"), do: "rounded-3xl"
  defp get_border_radius_classes("xl"), do: "rounded-[24px]"
  defp get_border_radius_classes(_), do: nil

  defp get_shadow_classes("sm"), do: "shadow-sm"
  defp get_shadow_classes("sm-2"), do: "shadow-sm-2"
  defp get_shadow_classes("sm-3"), do: "shadow-sm-3"
  defp get_shadow_classes("sm-4"), do: "shadow-sm-4"
  defp get_shadow_classes("md"), do: "shadow-md"
  defp get_shadow_classes("md-2"), do: "shadow-md-2"
  defp get_shadow_classes("md-3"), do: "shadow-md-3"
  defp get_shadow_classes("md-4"), do: "shadow-md-4"
  defp get_shadow_classes("lg"), do: "shadow-lg"
  defp get_shadow_classes("lg-2"), do: "shadow-lg-2"
  defp get_shadow_classes("lg-3"), do: "shadow-lg-3"
  defp get_shadow_classes("lg-4"), do: "shadow-lg-4"
  defp get_shadow_classes(_), do: nil

  defp get_border_classes(true), do: "border border-neutral-300"
  defp get_border_classes(_), do: ""

  defp get_background_classes("white"), do: "bg-white"
  defp get_background_classes("neutral"), do: "bg-neutral-300"
end
