defmodule PhoenixUiComponents.Tooltip do
  use Phoenix.Component

  @doc """
    A reusable tooltip component for Phoenix LiveView applications.

    This module provides a flexible tooltip component with configurable placement,
    strategy, and styling options.

    ## Attributes
    - `id`: Optional unique identifier for the tooltip
    - `class`: Additional CSS classes for the tooltip
    - `arrow_class`: Additional CSS classes for the tooltip arrow
    - `reference` Optional CSS selector for the element that triggers the tooltip.
       Defaults to the previous element sibling if not specified.
    - `placement`: Position of the tooltip (default: "top")
    - `strategy`: Positioning strategy - "absolute" or "fixed" (default: "absolute")
    - `text`: Optional text content for the tooltip
    - `delay`: Optional delay in milliseconds before tooltip appears (default: 500)
    - `disable_hover`: Optional boolean to disable hover interaction (default: false)
    - `hide_arrow`: Optional boolean to hide tooltip arrow (default: false)

    ## Supported Placements
    - top, top-start, top-end
    - right, right-start, right-end
    - bottom, bottom-start, bottom-end
    - left, left-start, left-end

    ## Example
        <button>Trigger</button>
        <.tooltip text="Tooltip description" />
  """

  @placement [
    "top",
    "top-start",
    "top-end",
    "right",
    "right-start",
    "right-end",
    "bottom",
    "bottom-start",
    "bottom-end",
    "left",
    "left-start",
    "left-end"
  ]
  @strategy [
    "absolute",
    "fixed"
  ]

  attr :text, :string, default: nil
  attr :delay, :any, default: 500
  attr :id, :string, default: nil
  attr :class, :any, default: nil
  attr :arrow_class, :any, default: nil
  attr :reference, :string, default: nil
  attr :placement, :string, values: @placement, default: "top"
  attr :strategy, :string, values: @strategy, default: "absolute"
  attr :disable_hover, :boolean, default: false
  attr :hide_arrow, :boolean, default: false
  attr :rest, :global
  slot :inner_block

  def tooltip(assigns) do
    ~H"""
    <div
      id={@id || "tooltip-#{System.unique_integer()}"}
      phx-hook="Tooltip"
      class={[
        "tooltip",
        case @strategy do
          "absolute" -> "absolute"
          "fixed" -> "fixed"
        end,
        @class
      ]}
      data-delay={@delay}
      data-placement={@placement}
      data-strategy={@strategy}
      data-reference={@reference}
      data-disable-hover={@disable_hover}
      role="tooltip"
      {@rest}
    >
      {@text || render_slot(@inner_block)}
      <div :if={!@hide_arrow} class={["tooltip-arrow", @arrow_class]} data-tooltip-arrow />
    </div>
    """
  end
end
