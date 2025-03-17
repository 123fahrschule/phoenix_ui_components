defmodule Storybook.Components.Button do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.Button

  @variants ["filled", "outlined", "text"]
  @sizes ["sm", "md", "lg"]
  @colors ["primary", "secondary", "neutral", "info", "success", "warning", "error"]

  def function, do: &Button.button/1

  def variations() do
    [
      %Variation{
        id: :default_button,
        attributes: %{
          label: "Default button"
        }
      },
      %VariationGroup{
        id: :predefined_variants,
        description: "With predefined variants",
        variations: [
          %Variation{
            id: :primary,
            attributes: %{
              label: "Primary",
              primary: true
            }
          },
          %Variation{
            id: :secondary,
            attributes: %{
              label: "Secondary",
              secondary: true
            }
          },
          %Variation{
            id: :tertiary,
            attributes: %{
              label: "Tertiary",
              tertiary: true
            }
          }
        ]
      },
      %VariationGroup{
        id: :predefined_sizes,
        description: "Sizes",
        variations:
          for variant <- @variants, size <- @sizes do
            %Variation{
              id: String.to_atom(variant <> size),
              attributes: %{
                label: "Button " <> size,
                variant: variant,
                size: size
              }
            }
          end
      },
      %VariationGroup{
        id: :predefined_variants_colors,
        description: "Variants and colors",
        variations:
          for variant <- @variants, color <- @colors do
            %Variation{
              id: String.to_atom(variant <> color),
              attributes: %{
                label: variant,
                variant: variant,
                color: color
              }
            }
          end
      },
      %VariationGroup{
        id: :predefined_variants_disabled,
        description: "Disabled state",
        variations:
          for variant <- @variants do
            %Variation{
              id: String.to_atom(variant <> "disabled"),
              attributes: %{
                label: variant,
                variant: variant,
                disabled: true
              }
            }
          end
      },
      %VariationGroup{
        id: :with_icon,
        description: "With icon",
        variations: [
          %Variation{
            id: :left_icon,
            attributes: %{
              label: "Left icon",
              left_icon: :chevron_left
            }
          },
          %Variation{
            id: :right_icon,
            attributes: %{
              label: "Right icon",
              right_icon: :chevron_right
            }
          },
          %Variation{
            id: :both_side__icon,
            attributes: %{
              label: "Icons on both sides",
              left_icon: :chevron_left,
              right_icon: :chevron_right
            }
          }
        ]
      },
      %VariationGroup{
        id: :icon_only,
        description: "Icon button",
        variations:
          for variant <- @variants do
            %Variation{
              id: String.to_atom(variant <> "icon_only"),
              attributes: %{
                variant: variant,
                icon: :add
              }
            }
          end
      }
    ]
  end
end
