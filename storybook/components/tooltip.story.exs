defmodule Storybook.Components.Tooltip do
  # TODO: fix deployment to Heroku when storybook uses components from external libraries
  use PhoenixStorybook.Story, :component

  def function, do: &PhoenixUiComponents.Tooltip.tooltip/1

  def variations do
    [
      %Variation{
        id: :default_tooltip,
        description: "Default tooltip on top of a button",
        template: """
        <button>Hover me</button>
        <.psb-variation />
        """,
        attributes: %{
          text: "Simple tooltip content"
        }
      },
      %Variation{
        id: :custom_trigger,
        description: "Tooltip with custom trigger selector",
        template: """
        <div>
          <button id="custom-trigger-btn">Custom Trigger</button>
          <p>Some additional content</p>
          <.psb-variation reference="#custom-trigger-btn" />
        </div>
        """,
        slots: ["Tooltip for custom trigger"]
      },
      %Variation{
        id: :custom_content,
        description: "Tooltip with custom content",
        template: """
        <button>Hover me</button>
        <.psb-variation />
        """,
        slots: [
          """
          <p>Tooltip title</p>
          <hr/>
          <p>Tooltip description</p>
          """
        ]
      },
      %Variation{
        id: :custom_delay,
        description: "Tooltip with custom show delay",
        template: """
        <button>Hover me</button>
        <.psb-variation />
        """,
        attributes: %{
          delay: 2_000,
          text: "Custom delay tooltip"
        }
      },
      %VariationGroup{
        id: :placement_variations,
        description: "Tooltip placement options",
        template: """
        <button>Hover me</button>
        <.psb-variation />
        """,
        variations:
          for placement <- ["top", "right", "bottom", "left"] do
            %Variation{
              id: String.to_atom("placement_" <> placement),
              description: "#{String.capitalize(placement)} Placement ",
              attributes: %{
                text: placement,
                placement: placement
              }
            }
          end
      },
      %Variation{
        id: :manual_trigger,
        description: "Manually triggered tooltip",
        template: """
        <button phx-click={JS.dispatch("tooltip:show", to: "#tooltip-single-manual-trigger" )}>Show tooltip</button>
        <button phx-click={JS.dispatch("tooltip:hide", to: "#tooltip-single-manual-trigger" )}>Hide tooltip</button>
        <p>Reference</p>
        <.psb-variation
          disable_hover={true}
          text="Manually triggered tooltip"
          placement="bottom"
          delay={nil}
        />
        """
      },
      %Variation{
        id: :styled_tooltip,
        description: "Tooltip with custom classes",
        template: """
        <button>Styled Tooltip</button>
        <.psb-variation 
          class="bg-blue-500 text-white p-2 rounded" 
          arrow_class="bg-blue-500"
        />
        """,
        slots: ["Styled Tooltip with Custom Classes"]
      }
    ]
  end
end
