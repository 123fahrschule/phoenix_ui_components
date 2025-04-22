defmodule Storybbok.Components.NavigationItem do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.Sidebar

  def imports,
    do: [
      {Sidebar, navigation_group: 1},
      {Sidebar, navigation_item_badge: 1},
      {Sidebar, navigation_subitem: 1}
    ]

  def function, do: &Sidebar.navigation_item/1

  def template,
    do: """
    <div psb-code-hidden class="w-full bg-neutral-900 px-2 py-4">
      <.navigation_group label="Navigation group">
        <.psb-variation />
      </.navigation_group>
    </div>
    """

  def variations,
    do: [
      %Variation{
        id: :default,
        description: "Simple navigation item",
        attributes: %{
          icon: "dashboard",
          label: "Page one",
          navigate: "#"
        }
      },
      %VariationGroup{
        id: :navigation,
        description: "Simple navigation item",
        template: """
          <div psb-code-hidden class="w-full bg-neutral-900 px-2 py-4">
            <.navigation_group label="Navigation group">
              <.psb-variation-group />
            </.navigation_group>
          </div>
        """,
        variations: [
          %Variation{
            id: :navigate,
            attributes: %{
              icon: "dashboard",
              label: "Live navigation",
              navigate: "#"
            }
          },
          %Variation{
            id: :pathc,
            attributes: %{
              icon: "dashboard",
              label: "Live patch",
              patch: "#"
            }
          },
          %Variation{
            id: :redirect,
            attributes: %{
              icon: "dashboard",
              label: "Redirect",
              href: "#"
            }
          }
        ]
      },
      %Variation{
        id: :active_state,
        description: "Active state",
        attributes: %{
          icon: "dashboard",
          label: "Page one",
          navigate: "#",
          active: true
        }
      },
      %Variation{
        id: :badge,
        description: "With badge",
        attributes: %{
          icon: "dashboard",
          label: "Page one",
          navigate: "#"
        },
        slots: [
          """
          <.navigation_item_badge text="10" />
          """
        ]
      },
      %Variation{
        id: :subitems,
        description: "With nested subitems",
        attributes: %{
          icon: "dashboard",
          label: "Subitems"
        },
        slots: [
          """
          <:subitems>
            <.navigation_subitem label="Page one" navigate="#" />
            <.navigation_subitem label="Page two" navigate="#" />
            <.navigation_subitem label="Page three" navigate="#" />
          </:subitems>
          """
        ]
      },
      %Variation{
        id: :subitems_expanded,
        description: "With nested subitems expanded by default",
        attributes: %{
          icon: "dashboard",
          label: "Subitems expanded",
          expanded: true
        },
        slots: [
          """
          <:subitems>
            <.navigation_subitem label="Page one" navigate="#" />
            <.navigation_subitem label="Page two" navigate="#" />
            <.navigation_subitem label="Page three" navigate="#" />
          </:subitems>
          """
        ]
      }
    ]
end
