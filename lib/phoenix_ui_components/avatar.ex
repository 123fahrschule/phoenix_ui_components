defmodule PhoenixUiComponents.Avatar do
  use PhoenixUiComponents, :component

  attr(:class, :string, default: nil)
  attr(:src, :string)
  attr(:initials, :string)
  attr(:shape, :string, values: ["circle", "square"], default: "circle")
  attr(:rest, :global)

  def avatar(%{src: _} = assigns) do
    ~H"""
    <img src={@src} class={get_classes(assigns)} {@rest} />
    """
  end

  def avatar(%{initials: _} = assigns) do
    ~H"""
    <div
      class={["flex items-center justify-center text-sm font-semibold", get_classes(assigns)]}
      {@rest}
    >
      <%= @initials %>
    </div>
    """
  end

  def avatar(assigns) do
    ~H"""
    <div class={["flex items-center justify-center", get_classes(assigns)]} {@rest}>
      <MaterialIcons.icon icon={:account_circle} class="text-[20px]" />
    </div>
    """
  end

  defp get_classes(%{class: class, shape: shape}) do
    ["w-8 h-8 bg-neutral-300 text-neutral-900", get_shape_classes(shape), class]
  end

  defp get_shape_classes("circle"), do: "rounded-full"
  defp get_shape_classes("square"), do: "rounded-lg"
end
