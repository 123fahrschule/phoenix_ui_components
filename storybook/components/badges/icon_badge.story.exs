defmodule Storybook.Components.IconBadge do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.Badge
  alias PhoenixUiComponents.Icon

  @sizes Badge.badge_sizes()
  @colors Badge.badge_colors()

  def imports,
    do: [
      {Icon, icon: 1}
    ]

  def function, do: &Badge.icon_badge/1

  def variations() do
    [
      %Variation{
        id: :default_badge,
        attributes: %{
          icon: :check
        }
      },
      %VariationGroup{
        id: :predefined_colors,
        description: "With predefined colors",
        variations:
          for color <- @colors do
            %Variation{
              id: String.to_atom(color),
              attributes: %{
                icon: :check,
                color: color
              }
            }
          end
      },
      %VariationGroup{
        id: :predefined_sizes,
        description: "With predefined sizes",
        variations:
          for size <- @sizes do
            %Variation{
              id: String.to_atom(size),
              attributes: %{
                icon: :check,
                size: size
              }
            }
          end
      },
      %Variation{
        id: :custom_icon,
        slots: [
          "<.icon outlined icon={:check_circle} />"
        ]
      }
    ]
  end
end
