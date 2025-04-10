defmodule PhoenixUiComponents.CustomLink do
  use PhoenixUiComponents, :component

  attr :label, :string, default: nil
  attr :type, :string, default: "button"
  attr :rest, :global, include: ["href", "navigate", "patch", "method"]

  slot :inner_block

  def custom_link(%{rest: rest} = assigns)
      when is_map_key(rest, :href)
      when is_map_key(rest, :navigate)
      when is_map_key(rest, :patch) do
    ~H"""
    <.link {@rest}>
      <%= if @label, do: @label, else: render_slot(@inner_block) %>
    </.link>
    """
  end

  def custom_link(assigns) do
    ~H"""
    <button type={@type} {@rest}>
      <%= if @label, do: @label, else: render_slot(@inner_block) %>
    </button>
    """
  end
end
