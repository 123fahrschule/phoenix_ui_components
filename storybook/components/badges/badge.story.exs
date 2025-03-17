defmodule Storybook.Components.Badge do
  use PhoenixStorybook.Story, :component

  alias Phoenix.LiveView.JS
  alias PhoenixUiComponents.Badge
  alias PhoenixUiComponents.Icon

  @sizes Badge.badge_sizes()
  @colors Badge.badge_colors()

  def imports,
    do: [
      {Icon, icon: 1},
      {Badge, badge_label: 1}
    ]

  def function, do: &Badge.badge/1

  def variations() do
    [
      %Variation{
        id: :default_badge,
        attributes: %{
          label: "Default badge"
        }
      },
      %Variation{
        id: :long_text,
        attributes: %{
          label:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut auctor, libero sit amet varius imperdiet, justo lacus vulputate arcu, at aliquam urna justo consequat ligula."
        }
      },
      %VariationGroup{
        id: :predefined_colors,
        description: "Colors",
        variations:
          for color <- @colors do
            %Variation{
              id: String.to_atom(color),
              attributes: %{
                label: color,
                color: color
              }
            }
          end
      },
      %VariationGroup{
        id: :predefined_sizes,
        description: "Sizes",
        variations:
          for size <- @sizes do
            %Variation{
              id: String.to_atom(size),
              attributes: %{
                label: "size: #{size}",
                size: size
              }
            }
          end
      },
      %VariationGroup{
        id: :with_icons,
        description: "With icons",
        variations: [
          %Variation{
            id: :left_icon,
            attributes: %{
              label: "with left icon",
              left_icon: :keyboard_arrow_left
            }
          },
          %Variation{
            id: :right_icon,
            attributes: %{
              label: "with right icon",
              right_icon: :keyboard_arrow_right
            }
          },
          %Variation{
            id: :both_side_icon,
            attributes: %{
              label: "with icons on both sides",
              left_icon: :keyboard_arrow_left,
              right_icon: :keyboard_arrow_right
            }
          },
          %Variation{
            id: :custom_icons,
            slots: [
              "<.icon icon={:keyboard_arrow_left} />",
              "<.badge_label text=\"with custom icons\" />",
              "<.icon icon={:keyboard_arrow_right} />"
            ]
          }
        ]
      },
      %VariationGroup{
        id: :remove_button,
        description: "Remove button",
        variations:
          for color <- @colors do
            %Variation{
              id: String.to_atom(color <> "_remove_button"),
              attributes: %{
                label: "with 'remove' button",
                color: color,
                on_remove: %JS{}
              }
            }
          end
      }
    ]
  end
end
