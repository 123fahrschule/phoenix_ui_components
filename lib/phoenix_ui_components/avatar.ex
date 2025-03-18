defmodule PhoenixUiComponents.Avatar do
  @moduledoc """
  Provides a flexible Avatar component with support for images, initials, and default icon.

  The Avatar component can be rendered in three ways:
  1. With an image source
  2. With initials text
  3. With a default account circle icon

  ## Attributes
  - `class`: Additional CSS classes to apply to the avatar
  - `src`: Image source URL for the avatar
  - `initials`: Text initials to display in the avatar
  - `shape`: Avatar shape, either "circle" (default) or "square"
  - `rest`: Additional HTML attributes to pass to the underlying element
  """
  use PhoenixUiComponents, :component

  import PhoenixUiComponents.Icon

  attr(:class, :string, default: nil, doc: "Additional CSS classes to apply to the avatar")
  attr(:src, :string, doc: "Image source URL for the avatar")
  attr(:initials, :string, doc: "Text initials to display in the avatar")

  attr(:shape, :string,
    values: ["circle", "square"],
    default: "circle",
    doc: "Shape of the avatar (circle or square)"
  )

  attr(:rest, :global, doc: "Additional HTML attributes to pass to the underlying element")

  @doc """
  Renders an avatar component

  ## Examples
      <.avatar />
      <.avatar shape="square" />
  """
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
      <.icon icon={:account_circle} class="text-[20px]" />
    </div>
    """
  end

  defp get_classes(%{class: class, shape: shape}) do
    ["w-8 h-8 bg-neutral-300 text-neutral-900", get_shape_classes(shape), class]
  end

  defp get_shape_classes("circle"), do: "rounded-full"
  defp get_shape_classes("square"), do: "rounded-lg"
end
