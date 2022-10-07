defmodule PhoenixUiComponents.Avatar do
  use PhoenixUiComponents, :component

  # attr :class :string, default: nil
  # attr :src :string, default: nil
  # attr :initials :string, default: nil
  # attr :shape, :string, default: "circle", values: ["circle", "square"]
  # attr :rest, :global
  def avatar(assigns) do
    assigns =
      assigns
      |> assign_class()
      |> assign_attr(:shape, "circle")
      |> assign_rest([:shape, :class])

    ~H"""
    <.content
      class={
        List.flatten(["w-8 h-8 bg-neutral-300 text-neutral-900", get_shape_classes(@shape), @class])
      }
      {@rest}
    />
    """
  end

  defp content(%{src: src} = assigns) when is_binary(src) do
    ~H"""
    <img {assigns} />
    """
  end

  defp content(%{initials: initials} = assigns) when is_binary(initials) do
    assigns =
      assigns
      |> assign_rest([:initials])

    ~H"""
    <div
      class={List.flatten(["flex items-center justify-center text-sm font-semibold", @class])}
      {@rest}
    >
      <%= @initials %>
    </div>
    """
  end

  defp content(assigns) do
    assigns =
      assigns
      |> assign_rest()

    ~H"""
    <div class={List.flatten(["flex items-center justify-center", @class])} {@rest}>
      <MaterialIcons.icon icon={:account_circle} class="text-[20px]" />
    </div>
    """
  end

  defp get_shape_classes("circle"), do: "rounded-full"
  defp get_shape_classes("square"), do: "rounded-lg"
end
