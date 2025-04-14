defmodule PhoenixUiComponents.Typography do
  use PhoenixUiComponents, :component

  attr :class, :any, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def h1(assigns) do
    ~H"""
    <h1 class={[get_title_classes("h1"), @class]} {@rest}>{render_slot(@inner_block)}</h1>
    """
  end

  attr :class, :any, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def h2(assigns) do
    ~H"""
    <h2 class={[get_title_classes("h2"), @class]} {@rest}>{render_slot(@inner_block)}</h2>
    """
  end

  attr :class, :any, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def h3(assigns) do
    ~H"""
    <h3 class={[get_title_classes("h3"), @class]} {@rest}>{render_slot(@inner_block)}</h3>
    """
  end

  attr :class, :any, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def h4(assigns) do
    ~H"""
    <h4 class={[get_title_classes("h4"), @class]} {@rest}>{render_slot(@inner_block)}</h4>
    """
  end

  attr :class, :any, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def h5(assigns) do
    ~H"""
    <h5 class={[get_title_classes("h5"), @class]} {@rest}>{render_slot(@inner_block)}</h5>
    """
  end

  attr :class, :any, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def h6(assigns) do
    ~H"""
    <h6 class={[get_title_classes("h6"), @class]} {@rest}>{render_slot(@inner_block)}</h6>
    """
  end

  attr :class, :any, default: nil
  attr :size, :string, values: ["md", "sm", "xs"], default: "md"
  attr :rest, :global

  slot :inner_block, required: true

  def p(assigns) do
    assigns =
      assigns
      |> assign_class
      |> assign_attr(:size, "md")
      |> assign_rest([:class, :rest])

    ~H"""
    <p class={[get_body_classes(@size), @class]} {@rest}>{render_slot(@inner_block)}</p>
    """
  end

  defp get_title_classes("h1"), do: "text-5xl leading-tight font-bold tracking-[0.24px]"
  defp get_title_classes("h2"), do: "text-[32px] leading-normal font-bold tracking-[0.16px]"
  defp get_title_classes("h3"), do: "text-2xl leading-[1.334] font-bold tracking-normal"
  defp get_title_classes("h4"), do: "text-xl leading-[1.4] font-bold tracking-normal"
  defp get_title_classes("h5"), do: "text-normal leading-tight font-bold tracking-normal"

  defp get_title_classes("h6"),
    do: "text-sm leading-[1.334] font-bold tracking-[0.48px] uppercase"

  defp get_body_classes("md"), do: "text-normal leading-normal tracking-normal"
  defp get_body_classes("sm"), do: "text-sm leading-[1.429] tracking-normal"
  defp get_body_classes("xs"), do: "text-xs leading-[1.334] tracking-normal"
end
