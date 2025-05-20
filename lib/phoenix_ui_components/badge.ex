defmodule PhoenixUiComponents.Badge do
  @moduledoc """
    Provides a flexible Badge component with multiple variations and customization options.

    The Badge component supports:
    - Different sizes (xs, sm, md, lg)
    - Various color schemes (neutral, info, success, warning, error)
    - Optional icons
    - Removable badges
    - Custom content
  """

  use PhoenixUiComponents, :component

  import PhoenixUiComponents.Icon

  @sizes ["xs", "sm", "md", "lg"]
  @colors ["neutral", "info", "success", "warning", "error"]

  # Tailwind safelist
  # badge-xs badge-sm badge-md badge-lg
  # badge-neutral badge-info badge-success badge-warning badge-error

  def badge_sizes(), do: @sizes
  def badge_colors(), do: @colors

  attr :class, :any, default: nil
  attr :label, :string, default: nil
  attr :size, :string, values: @sizes, default: "md"
  attr :color, :string, values: @colors, default: "neutral"

  attr :type, :any,
    values: [nil | @colors],
    default: nil,
    doc: "Deprecated. Use `color` instead"

  attr :left_icon, :atom, default: nil
  attr :right_icon, :atom, default: nil
  attr :on_remove, JS, default: nil
  attr :rest, :global

  slot :inner_block

  @doc """
  Renders a badge component.

  ## Examples
      <.badge label="Verified" left_icon={:check} />
      <.badge label="Important" color="warning" right_icon={:warning} />
  """
  def badge(%{on_remove: on_remove} = assigns) when not is_nil(on_remove) do
    ~H"""
    <span class={["badge badge-#{@size} badge-#{@type || @color}", @class]} {@rest}>
      <.badge_label text={@label} />
      <button type="button" class="badge-remove-button" phx-click={@on_remove}>
        <.icon icon={:close} />
      </button>
    </span>
    """
  end

  def badge(%{label: label} = assigns) when not is_nil(label) do
    ~H"""
    <span class={["badge badge-#{@size} badge-#{@color}", @class]} {@rest}>
      <.icon :if={@left_icon} icon={@left_icon} />
      <.badge_label text={@label} />
      <.icon :if={@right_icon} icon={@right_icon} />
    </span>
    """
  end

  def badge(assigns) do
    ~H"""
    <span class={["badge badge-#{@size} badge-#{@color}", @class]} {@rest}>
      {render_slot(@inner_block)}
    </span>
    """
  end

  attr :text, :string, default: nil
  attr :class, :any, default: nil
  attr :rest, :global

  @doc """
  Renders a badge component.

  ## Examples
      <.badge_label text="New" />
      <.badge_label text="Custom" class="text-blue-500" />
  """
  def badge_label(assigns) do
    ~H"""
    <span class={["badge-label", @class]} {@rest}>
      {@text}
    </span>
    """
  end

  attr :class, :any, default: nil
  attr :icon, :atom, default: nil
  attr :outlined, :boolean, default: false
  attr :size, :string, values: @sizes, default: "md"
  attr :color, :string, values: @colors, default: "neutral"

  slot :inner_block

  @doc """
  Renders a badge containing only an icon or custom content.

  ## Examples
      <.icon_badge icon={:star} color="warning" />
      <.icon_badge>
        <span>Custom Icon</span>
      </.icon_badge>
  """
  def icon_badge(assigns) do
    ~H"""
    <.badge size={@size} color={@color} class={@class}>
      <%= if @icon do %>
        <.icon outlined={@outlined} icon={@icon} />
      <% else %>
        {render_slot(@inner_block)}
      <% end %>
    </.badge>
    """
  end
end
