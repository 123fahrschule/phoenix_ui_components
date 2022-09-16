defmodule PhoenixUiComponents.Button do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Link

  # attr :type :string, default: "button"
  # attr :class :string, default: nil
  # attr :label :string, default: nil
  # attr :variant :string, default: "primary", doc: ~s'Available options: "primary", "secondary", "tertiary"'
  # attr :size :string, default: "md", doc: ~s'Available options: "sm", "md", "lg"'
  # attr :icon :atom, default: nil
  # attr :left_icon :atom, default: nil
  # attr :right_icon :atom, default: nil
  # attr :rest, :global
  # slot :inner_block
  def button(assigns) do
    assigns =
      assigns
      |> assign_class
      |> assign_attr(:type, "button")
      |> assign_attr(:label)
      |> assign_attr(:variant, "primary")
      |> assign_attr(:size, "md")
      |> assign_attr(:icon)
      |> assign_attr(:left_icon)
      |> assign_attr(:right_icon)
      |> assign_slot(:inner_block)
      |> assign_rest([:type, :class, :label, :variant, :size, :icon, :left_icon, :right_icon])

    ~H"""
    <.link
      type={@type}
      class={
        [
          "inline-flex items-center justify-center rounded-full transition duration-150 ease-in-out font-bold uppercase align-middle",
          get_variant_classes(@variant),
          if(@icon, do: get_icon_button_size_classes(@size), else: get_size_classes(@size)),
          @class
        ]
      }
      {@rest}
    >
      <.content {assigns} />
    </.link>
    """
  end

  # attr :icon, :atom, required: true
  # attr :size, :string, required: true
  defp content(%{icon: icon} = assigns) when not is_nil(icon) do
    ~H"""
    <MaterialIcons.icon icon={@icon} class={get_icon_size_classes(@size)} />
    """
  end

  # attr :label :string, default: nil
  # attr :size :string, default: "md", doc: ~s'options: ["sm", "md", "lg"]'
  # attr :left_icon :atom, default: nil
  # attr :right_icon :atom, default: nil
  # slot :inner_block
  defp content(assigns) do
    ~H"""
    <%= if @left_icon do %>
      <MaterialIcons.icon icon={@left_icon} class={["mr-1 -ml-2 ", get_icon_size_classes(@size)]} />
    <% end %>
    <%= if @label, do: @label, else: render_slot(@inner_block) %>
    <%= if @right_icon do %>
      <MaterialIcons.icon icon={@right_icon} class={["-mr-2 ml-1 ", get_icon_size_classes(@size)]} />
    <% end %>
    """
  end

  defp get_variant_classes("primary"),
    do:
      "text-white bg-secondary-300 hover:bg-secondary-400 active:bg-secondary-400 focus:bg-secondary-400 disabled:bg-neutral-300 disabled:text-neutral-600"

  defp get_variant_classes("secondary"),
    do:
      "text-neutral-900 bg-white border border-neutral-900 hover:bg-neutral-200 active:bg-neutral-200 focus:bg-neutral-200 disabled:bg-white disabled:text-neutral-600 disabled:border-neutral-500"

  defp get_variant_classes("tertiary"),
    do:
      "text-secondary-300 hover:bg-neutral-200 active:bg-neutral-200 focus:bg-neutral-200 disabled:bg-white disabled:text-neutral-600"

  defp get_size_classes("sm"), do: "px-5 py-2 text-xs tracking-[0.5px]"
  defp get_size_classes("md"), do: "px-5 py-2.5 text-sm tracking-[0.5px]"
  defp get_size_classes("lg"), do: "px-5 py-3 text-base tracking-[0.5px]"

  defp get_icon_button_size_classes("sm"), do: "px-2 py-2"
  defp get_icon_button_size_classes("md"), do: "px-2.5 py-2.5"
  defp get_icon_button_size_classes("lg"), do: "px-3 py-3"

  defp get_icon_size_classes("sm"), do: "text-[16px]"
  defp get_icon_size_classes("md"), do: "text-[20px]"
  defp get_icon_size_classes("lg"), do: "text-[24px]"
end
