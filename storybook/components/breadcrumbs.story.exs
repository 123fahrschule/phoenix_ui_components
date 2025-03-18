defmodule Storybook.Components.Breadcrumbs do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.Breadcrumbs

  def function, do: &Breadcrumbs.breadcrumbs/1

  def layout, do: :one_column

  def variations do
    [
      %Variation{
        id: :base,
        description: "Simple breadcrumbs with links",
        attributes: %{
          breadcrumbs: [
            %{label: "Home", href: "/"},
            %{label: "Products", href: "/products"},
            %{label: "Electronics"}
          ]
        }
      },
      %Variation{
        id: :with_icons,
        description: "Breadcrumbs with icons",
        attributes: %{
          breadcrumbs: [
            %{label: "Home", icon: :home, href: "/"},
            %{label: "Categories", icon: :category, href: "/categories"},
            %{label: "Current Page", icon: :info}
          ]
        }
      },
      %Variation{
        id: :mixed_navigation,
        description: "Breadcrumbs with different navigation types",
        attributes: %{
          breadcrumbs: [
            %{label: "Home", href: "/"},
            %{label: "Dashboard", patch: "/dashboard"},
            %{label: "Profile", navigate: "/profile"}
          ]
        }
      },
      %Variation{
        id: :custom_styles,
        description: "Breadcrumbs with custom CSS class",
        attributes: %{
          breadcrumbs: [
            %{label: "Home", href: "/"},
            %{label: "Products", href: "/products"},
            %{label: "Electronics"}
          ],
          class: "bg-gray-100 p-2 rounded-md"
        }
      }
    ]
  end
end
