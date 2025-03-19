defmodule Storybook.Components.PageHeader do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.Badge
  alias PhoenixUiComponents.Button
  alias PhoenixUiComponents.Page
  alias PhoenixUiComponents.Tabs

  def layout, do: :one_column

  def imports,
    do: [
      {Badge, badge: 1},
      {Button, button: 1},
      {Page, page: 1},
      {Tabs, tabs: 1, tab: 1}
    ]

  def template,
    do: """
      <div psb-code-hidden class="w-full" >
       <.psb-variation />
      </div>

    """

  def function, do: &Page.page_header/1

  def variations do
    [
      %Variation{
        id: :basic_header,
        description: "Basic page header with title",
        attributes: %{
          title: "Dashboard"
        }
      },
      %Variation{
        id: :with_breadcrumbs,
        description: "Page header with breadcrumbs",
        attributes: %{
          title: "Dashboard",
          breadcrumbs: [
            %{label: "Home", href: "/"},
            %{label: "Dashboard"}
          ]
        }
      },
      %Variation{
        id: :header_with_actions,
        description: "Page header with action buttons",
        attributes: %{
          title: "User Management",
          breadcrumbs: [
            %{label: "Home", href: "/"},
            %{label: "Users", href: "/users"}
          ]
        },
        slots: [
          """
          <:action>
            <.button primary label="Create User" />
          </:action>
          """,
          """
          <:action>
            <.button secondary label="Export" />
          </:action>
          """
        ]
      },
      %Variation{
        id: :header_with_title_content,
        description: "Page header with additional title content",
        attributes: %{
          title: "Project Details",
          breadcrumbs: [
            %{label: "Home", href: "/"},
            %{label: "Projects", href: "/projects"},
            %{label: "Project Details", href: "/projects/1"}
          ]
        },
        slots: [
          """
          <:title_content>
            <.badge color="success" label="Active" class="ml-2" />
          </:title_content>
          """
        ]
      },
      %Variation{
        id: :header_with_inner_block,
        description: "Page header with inner block content",
        attributes: %{
          title: "Settings",
          breadcrumbs: [
            %{label: "Home", href: "/"},
            %{label: "Account", href: "/account"},
            %{label: "Settings", href: "/account/settings"}
          ]
        },
        slots: [
          """
          <.tabs>
            <.tab active label="General" target="#tab_one" />
            <.tab label="Contact details" target="#tab_two" />
          </.tabs>
          """
        ]
      }
    ]
  end
end
