defmodule Storybook.Components.DetailsList do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.DetailsList

  def function, do: &DetailsList.details_list/1

  def variations do
    [
      %Variation{
        id: :default,
        description: "Simple list of key-value pairs",
        attributes: %{},
        slots: [
          """
          <:item term="Name" details="John Doe" />
          """,
          """
          <:item term="Email" details="john.doe@example.com" />
          """,
          """
          <:item term="Phone" details="+1 (555) 123-4567" />
          """
        ]
      },
      %Variation{
        id: :inner_block,
        description: "Details list with custom inner block content",
        attributes: %{},
        slots: [
          """
          <:item term="Status" >
            <span class='text-green-500'>Active</span>
          </:item>
          """,
          """
          <:item term="Registration" details="john.doe@example.com" >
            <a href='/register' class='text-blue-500'>Complete Registration</a>
          </:item>
          """
        ]
      }
    ]
  end
end
