defmodule Storybbok.Components.DevTools do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.DevTools
  alias PhoenixUiComponents.Sidebar

  def imports,
    do: [
      {Sidebar, navigation_group: 1}
    ]

  def function, do: &DevTools.dev_tools_navigation_item/1

  def template,
    do: """
    <div psb-code-hidden class="w-full bg-neutral-900 px-2 py-4">
      <.navigation_group label="dev tools">
        <.psb-variation />
      </.navigation_group>
    </div>
    """

  def variations,
    do: [
      %Variation{
        id: :default,
        description: "Default",
        attributes: %{
          primary: "Service name",
          icon: :dashboard,
          href: "#"
        }
      },
      %Variation{
        id: :warning,
        description: "Warning state",
        attributes: %{
          primary: "Service name",
          icon: :dashboard,
          href: "#",
          warnings_count: 1
        }
      },
      %Variation{
        id: :error,
        description: "Error state",
        attributes: %{
          primary: "Service name",
          icon: :dashboard,
          href: "#",
          errors_count: 1
        }
      },
      %Variation{
        id: :with_secondary_text,
        description: "With custom secondary text",
        attributes: %{
          primary: "Service name",
          icon: :dashboard,
          href: "#",
          secondary: "Service description"
        }
      },
      %Variation{
        id: :without_secondary_text,
        description: "Without secondary text",
        attributes: %{
          primary: "Service name",
          icon: :dashboard,
          href: "#",
          secondary: {:eval, false}
        }
      }
    ]
end
