defmodule PhoenixUiComponents.Button do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Icon
  import PhoenixUiComponents.CustomLink

  attr :type, :string, default: "button"
  attr :class, :any, default: nil
  attr :label, :string, default: nil

  attr :color, :string,
    values: ["primary", "secondary", "neutral", "info", "success", "warning", "error", "white"],
    default: "primary"

  attr :variant, :string, values: ["filled", "outlined", "text"], default: "filled"
  attr :size, :string, values: ["sm", "md", "lg"], default: "md"
  attr :icon, :atom, default: nil
  attr :left_icon, :atom, default: nil
  attr :right_icon, :atom, default: nil
  attr :icon_attrs, :list, default: []
  attr :left_icon_attrs, :list, default: []
  attr :right_icon_attrs, :list, default: []
  attr :primary, :boolean, default: false
  attr :secondary, :boolean, default: false
  attr :tertiary, :boolean, default: false

  attr :rest, :global,
    include: ["href", "navigate", "patch", "form", "method", "name", "value", "disabled"]

  slot :inner_block

  def button(%{primary: true} = assigns) do
    assigns =
      assigns
      |> assign(:variant, "filled")
      |> assign(:color, "secondary")

    ~H"""
    <.custom_link type={@type} class={get_classes(assigns)} {@rest}>
      <.content {assigns} />
    </.custom_link>
    """
  end

  def button(%{secondary: true} = assigns) do
    assigns =
      assigns
      |> assign(:variant, "outlined")
      |> assign(:color, "neutral")

    ~H"""
    <.custom_link type={@type} class={get_classes(assigns)} {@rest}>
      <.content {assigns} />
    </.custom_link>
    """
  end

  def button(%{tertiary: true} = assigns) do
    assigns =
      assigns
      |> assign(:variant, "text")
      |> assign(:color, "secondary")

    ~H"""
    <.custom_link type={@type} class={get_classes(assigns)} {@rest}>
      <.content {assigns} />
    </.custom_link>
    """
  end

  def button(assigns) do
    ~H"""
    <.custom_link type={@type} class={get_classes(assigns)} {@rest}>
      <.content {assigns} />
    </.custom_link>
    """
  end

  defp content(%{icon: icon} = assigns) when not is_nil(icon) do
    ~H"""
    <.button_icon icon={@icon} default_class={get_icon_size_classes(@size)} {@icon_attrs} />
    """
  end

  defp content(assigns) do
    ~H"""
    <.button_icon
      :if={@left_icon}
      icon={@left_icon}
      default_class={list_class_value(["mr-1 -ml-2 ", get_icon_size_classes(@size)])}
      {@left_icon_attrs}
    />
    <%= if @label, do: @label, else: render_slot(@inner_block) %>
    <.button_icon
      :if={@right_icon}
      icon={@right_icon}
      default_class={list_class_value(["-mr-2 ml-1 ", get_icon_size_classes(@size)])}
      {@right_icon_attrs}
    />
    """
  end

  attr :icon, :atom, required: true
  attr :class, :any, default: nil
  attr :default_class, :string, default: nil
  attr :rest, :global

  defp button_icon(assigns) do
    ~H"""
    <.icon icon={@icon} class={list_class_value([@default_class, @class])} {@rest} />
    """
  end

  defp get_classes(%{
         class: class,
         variant: variant,
         color: color,
         size: size,
         icon: icon
       }) do
    [
      "inline-flex items-center justify-center rounded-full transition duration-150 ease-in-out font-bold align-middle",
      if(icon, do: get_icon_button_size_classes(size), else: get_size_classes(size)),
      get_active_state_classes(color, variant),
      get_text_color_classes(color, variant),
      get_color_classes(color, variant),
      get_disabled_classes(variant),
      class
    ]
  end

  defp get_active_state_classes(color, variant) when color != "white" and variant != "filled",
    do: "hover:bg-neutral-200 active:bg-neutral-200 focus:bg-neutral-200"

  defp get_active_state_classes(_, _), do: nil

  defp get_text_color_classes("primary", variant) do
    case variant do
      "filled" ->
        "text-white"

      _ ->
        "text-primary-300 hover:text-primary-400 active:text-primary-400 focus:text-primary-400"
    end
  end

  defp get_text_color_classes("secondary", variant) do
    case variant do
      "filled" ->
        "text-white"

      _ ->
        "text-secondary-300 hover:text-secondary-400 active:text-secondary-400 focus:text-secondary-400"
    end
  end

  defp get_text_color_classes("neutral", variant) do
    case variant do
      "filled" ->
        "text-white"

      _ ->
        "text-neutral-900 hover:text-neutral-600 active:text-neutral-600 focus:text-neutral-600"
    end
  end

  defp get_text_color_classes("info", variant) do
    case variant do
      "filled" ->
        "text-white"

      _ ->
        "text-info-300 hover:text-info-400 active:text-info-400 focus:text-info-400"
    end
  end

  defp get_text_color_classes("success", variant) do
    case variant do
      "filled" ->
        "text-white"

      _ ->
        "text-success-300 hover:text-success-400 active:text-success-400 focus:text-success-400"
    end
  end

  defp get_text_color_classes("warning", variant) do
    case variant do
      "filled" ->
        "text-white"

      _ ->
        "text-warning-300 hover:text-warning-400 active:text-warning-400 focus:text-warning-400"
    end
  end

  defp get_text_color_classes("error", variant) do
    case variant do
      "filled" ->
        "text-white"

      _ ->
        "text-error-300 hover:text-error-400 active:text-error-400 focus:text-error-400"
    end
  end

  defp get_text_color_classes("white", variant) do
    case variant do
      "filled" ->
        nil

      _ ->
        "text-white hover:text-neutral-300 active:text-neutral-300 focus:text-neutral-300"
    end
  end

  defp get_color_classes("primary", variant) do
    case variant do
      "filled" ->
        "bg-primary-300 hover:bg-primary-400 active:bg-primary-400 focus:bg-primary-400"

      "outlined" ->
        "border border-primary-300 hover:border-primary-400 active:border-primary-400 focus:border-primary-400"

      _ ->
        nil
    end
  end

  defp get_color_classes("secondary", variant) do
    case variant do
      "filled" ->
        "bg-secondary-300 hover:bg-secondary-400 active:bg-secondary-400 focus:bg-secondary-400"

      "outlined" ->
        "border border-secondary-300 hover:border-secondary-400 active:border-secondary-400 focus:border-secondary-400"

      _ ->
        nil
    end
  end

  defp get_color_classes("neutral", variant) do
    case variant do
      "filled" ->
        "bg-neutral-900 hover:bg-neutral-600 active:bg-neutral-600 focus:bg-neutral-600"

      "outlined" ->
        "border border-neutral-900 hover:border-neutral-600 active:border-neutral-600 focus:border-neutral-600"

      _ ->
        ""
    end
  end

  defp get_color_classes("info", variant) do
    case variant do
      "filled" ->
        "bg-info-300 hover:bg-info-400 active:bg-info-400 focus:bg-info-400"

      "outlined" ->
        "border border-info-300 hover:border-info-400 active:border-info-400 focus:border-info-400"

      _ ->
        nil
    end
  end

  defp get_color_classes("success", variant) do
    case variant do
      "filled" ->
        "bg-success-300 hover:bg-success-400 active:bg-success-400 focus:bg-success-400"

      "outlined" ->
        "border border-success-300 hover:border-success-400 active:border-success-400 focus:border-success-400"

      _ ->
        nil
    end
  end

  defp get_color_classes("warning", variant) do
    case variant do
      "filled" ->
        "bg-warning-300 hover:bg-warning-400 active:bg-warning-400 focus:bg-warning-400"

      "outlined" ->
        "border border-warning-300 hover:border-warning-400 active:border-warning-400 focus:border-warning-400"

      _ ->
        nil
    end
  end

  defp get_color_classes("error", variant) do
    case variant do
      "filled" ->
        "bg-error-300 hover:bg-error-400 active:bg-error-400 focus:bg-error-400"

      "outlined" ->
        "border border-error-300 hover:border-error-400 active:border-error-400 focus:border-error-400"

      _ ->
        nil
    end
  end

  defp get_color_classes("white", variant) do
    case variant do
      "filled" ->
        "bg-white hover:bg-neutral-300 active:bg-neutral-300 focus:bg-neutral-300"

      "outlined" ->
        "border border-white hover:border-neutral-300 active:border-neutral-300 focus:border-neutral-300"

      _ ->
        nil
    end
  end

  defp get_disabled_classes(variant) do
    case variant do
      "filled" -> "disabled:text-neutral-600 disabled:bg-neutral-200"
      "outlined" -> "disabled:text-neutral-600 disabled:border-neutral-500"
      _ -> "disabled:text-neutral-600"
    end
  end

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
