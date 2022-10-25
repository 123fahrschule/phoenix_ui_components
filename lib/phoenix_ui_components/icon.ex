defmodule PhoenixUiComponents.Icon do
  use PhoenixUiComponents, :component

  attr(:class, :string, default: nil)
  attr(:icon, :atom, required: true)
  attr(:outlined, :boolean, default: false)
  attr(:rest, :global)

  def icon(assigns) do
    ~H"""
    <span class={[get_material_icon_class(assigns), @class]} {@rest}>
      <%= @icon %>
    </span>
    """
  end

  defp get_material_icon_class(%{outlined: true}), do: "material-icons-outlined"
  defp get_material_icon_class(_), do: "material-icons"
end
