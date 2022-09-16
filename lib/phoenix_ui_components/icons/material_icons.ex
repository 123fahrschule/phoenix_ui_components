defmodule PhoenixUiComponents.Icons.MaterialIcons do
  use PhoenixUiComponents, :component

  # attr :class, :string, default: nil
  # attr :icon, :atom, required: true
  # attr :outlined, :boolean, default: false
  # attr :rest, :global
  def icon(assigns) do
    assigns =
      assigns
      |> assign_class
      |> assign_attr(:outlined, false)
      |> assign_rest([:class, :icon, :outlined])

    ~H"""
    <span class={[get_class(assigns), @class]} {@rest}><%= @icon %></span>
    """
  end

  defp get_class(%{outlined: true}), do: "material-icons-outlined"
  defp get_class(_), do: "material-icons"
end
