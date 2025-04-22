defmodule Storybbok.Components.NavigationGroup do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.Sidebar

  def imports,
    do: [
      {Sidebar, navigation_item: 1}
    ]

  def function, do: &Sidebar.navigation_group/1

  def template,
    do: """
    <div psb-code-hidden class="w-full bg-neutral-900 px-2 py-4">
        <.psb-variation />
    </div>
    """

  def variations,
    do: [
      %Variation{
        id: :default,
        description: "Simple navigation group",
        attributes: %{
          label: "Navigation group"
        },
        slots: [
          """
          <.navigation_item icon="dashboard" label="Page one" navigate="#" />
          <.navigation_item icon="dashboard" label="Page two" navigate="#" />
          <.navigation_item icon="dashboard" label="Page three" navigate="#" />
          """
        ]
      }
    ]
end
