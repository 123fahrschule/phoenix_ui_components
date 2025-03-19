defmodule Storybook.Components.Checkbox do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.Checkbox

  def function, do: &Checkbox.checkbox/1

  def variations do
    [
      %Variation{
        id: :base,
        description: "Standard checkbox with label",
        attributes: %{
          label: "Subscribe to newsletter"
        },
        template: """
        <.form for={%{}} :let={f} class="w-full">
          <.psb-variation form={f} field={:default} />
        </.form>
        """
      },
      %Variation{
        id: :small_size,
        description: "Checkbox with small size",
        attributes: %{
          label: "I accept (Small)",
          size: "sm"
        },
        template: """
        <.form for={%{}} :let={f} class="w-full">
          <.psb-variation form={f} field={:small_size} />
        </.form>
        """
      },
      %Variation{
        id: :large_size,
        description: "Checkbox with large size",
        attributes: %{
          label: "I accept (Large)",
          size: "lg"
        },
        template: """
        <.form for={%{}} :let={f} class="w-full">
          <.psb-variation form={f} field={:large_size} />
        </.form>
        """
      },
      %Variation{
        id: :inner_block,
        description: "Checkbox with inner block label",
        attributes: %{},
        template: """
        <.form for={%{}} :let={f} class="w-full">
          <.psb-variation form={f} field={:inner_block} />
        </.form>
        """,
        slots: [
          """
          <span class="text-blue-500">Complex Label</span>
          <small class="ml-2 text-gray-500">(with additional styling)</small>
          """
        ]
      }
    ]
  end
end
