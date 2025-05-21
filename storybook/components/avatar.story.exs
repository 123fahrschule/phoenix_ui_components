defmodule Storybook.Components.Avatar do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.Avatar

  def function, do: &Avatar.avatar/1

  def variations do
    [
      %Variation{
        id: :image_avatar,
        description: "Image Avatar",
        attributes: %{
          src: "https://i.pravatar.cc/300"
        }
      },
      %Variation{
        id: :initials_avatar,
        description: "Initials Avatar",
        attributes: %{
          initials: "JD"
        }
      },
      %Variation{
        id: :default_avatar,
        description: "Default Avatar",
        attributes: %{}
      },
      %Variation{
        id: :square_shape,
        description: "Square Avatar",
        attributes: %{
          shape: "square",
          initials: "JD"
        }
      },
      %VariationGroup{
        id: :different_sizes,
        description: "Different sizes",
        variations: [
          %Variation{
            id: :size_default
          },
          %Variation{
            id: :size_sm,
            attributes: %{
              size: "lg"
            }
          },
          %Variation{
            id: :size_custom,
            attributes: %{
              size: "size-4 [&>.icon]:text-[10px]"
            }
          }
        ]
      },
      %Variation{
        id: :custom_class,
        description: "Custom Styled Avatar",
        attributes: %{
          initials: "JD",
          class: "bg-blue-500 text-white"
        }
      }
    ]
  end
end
