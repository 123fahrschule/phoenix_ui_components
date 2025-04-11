defmodule Storybook.Components.FormField.Checkbox do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.FormField

  def function, do: &FormField.form_field/1

  def template,
    do: """
    <.form for={%{}} :let={f} class="w-full">
      <.psb-variation type="checkbox" field={f[:field]} label="Label" />
    </.form>
    """

  def variations,
    do: [
      %Variation{
        id: :default,
        description: "Default"
      },
      %Variation{
        id: :error,
        description: "Error",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <% f = %{f | params: %{"field"  => ""}, errors: [field: {"can't be blank", []}]} %>
            <.psb-variation type="checkbox" field={f[:field]} label="Label"/>
          </.form>
        """
      },
      %Variation{
        id: :disabled,
        description: "Disabled",
        attributes: %{
          disabled: true
        }
      },
      %Variation{
        id: :custom_label,
        description: "Custom label content",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <.psb-variation type="checkbox" field={f[:field]}/>
          </.form>
        """,
        slots: [
          """
          <p>
            Agree to <a href="#" class="underline">Terms and Conditions</a>
          </p>
          """
        ]
      },
      %Variation{
        id: :without_label,
        description: "Without label",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <.psb-variation type="checkbox" field={f[:field]}/>
          </.form>
        """
      }
    ]
end
