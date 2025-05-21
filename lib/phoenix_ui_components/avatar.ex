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

  attr :class, :any, default: nil, doc: "Additional CSS classes to apply to the avatar"
  attr :src, :string, doc: "Image source URL for the avatar"
  attr :initials, :string, doc: "Text initials to display in the avatar"

  attr :size, :string,
    default: "md",
    doc: "String with predefined size: 'md', 'lg' or size class: 'size-4'"

  attr :shape, :string,
    values: ["circle", "square"],
    default: "circle",
    doc: "Shape of the avatar (circle or square)"

  attr :rest, :global, doc: "Additional HTML attributes to pass to the underlying element"

  @doc """
  Renders an avatar component

  ## Examples
      <.avatar />
      <.avatar shape="square" />
  """
  def avatar(%{src: _} = assigns) do
    ~H"""
    <img
      src={@src}
      class={[default_classes(), shape_classes(@shape), size_classes(@size), @class]}
      {@rest}
    />
    """
  end

  def avatar(%{initials: _} = assigns) do
    ~H"""
    <div
      class={[
        "flex items-center justify-center text-body-sm font-semibold",
        default_classes(),
        shape_classes(@shape),
        size_classes(@size),
        @class
      ]}
      {@rest}
    >
      {@initials}
    </div>
    """
  end

  def avatar(assigns) do
    ~H"""
    <div
      class={[
        "flex items-center justify-center",
        default_classes(),
        shape_classes(@shape),
        size_classes(@size),
        @class
      ]}
      {@rest}
    >
      <.icon icon={:account_circle} />
    </div>
    """
  end

  defp default_classes, do: "bg-neutral-300 text-neutral-900"

  defp shape_classes("circle"), do: "rounded-full"
  defp shape_classes("square"), do: "rounded-lg"

  defp size_classes("md"), do: "size-8"
  defp size_classes("lg"), do: "size-10"
  defp size_classes(size_classes), do: size_classes
end
