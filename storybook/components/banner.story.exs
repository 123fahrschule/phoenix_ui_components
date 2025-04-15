defmodule Storybook.Components.Banner do
  use PhoenixStorybook.Story, :component

  alias Phoenix.LiveView.JS
  alias PhoenixUiComponents.Banner

  @colors ["info", "success", "warning", "error"]
  @sizes ["sm", "md", "lg"]
  @message "Lorem ipsum dolor sit amet consectetur adipisicing elit. Natus maiores nam libero nihil ab id esse consequuntur optio similique explicabo saepe, numquam officia minima praesentium animi, corrupti inventore ipsum? Non!"

  def function, do: &Banner.banner/1

  def variations() do
    [
      %Variation{
        id: :default_banner,
        attributes: %{
          message: "Default banner"
        }
      },
      %VariationGroup{
        id: :with_label,
        description: "With label text",
        variations: [
          %Variation{
            id: :label_banner,
            attributes: %{
              label: "Banner label text"
            }
          }
        ]
      },
      %VariationGroup{
        id: :with_message_and_label,
        description: "With label text and message",
        variations: [
          %Variation{
            id: :message_and_label_banner,
            attributes: %{
              label: "Banner label text",
              message: @message
            }
          }
        ]
      },
      %VariationGroup{
        id: :close_button,
        description: "With close button",
        variations: [
          %Variation{
            id: :close_button,
            attributes: %{
              label: "Banner label",
              message: @message,
              on_close: %JS{}
            }
          }
        ]
      },
      %VariationGroup{
        id: :predefined_colors,
        description: "With predefined colors",
        variations:
          for color <- @colors do
            %Variation{
              id: String.to_atom(color),
              attributes: %{
                label: "Banner label " <> color,
                message: @message,
                color: color,
                on_close: %JS{}
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
                label: "Banner label",
                message: @message,
                size: size
              }
            }
          end
      },
      %Variation{
        id: :custom_content,
        description: "With custom content",
        attributes: %{
          label: "Label"
        },
        slots: [
          """
          <ul class="list-inside list-disc">
            <li>One</li>
            <li>Two</li>
            <li>Three</li>
          </ul>
          """
        ]
      }
    ]
  end
end
