defmodule Storybook.Components.FormField.Textarea do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.FormField

  def function, do: &FormField.form_field/1

  def template,
    do: """
    <.form for={%{}} :let={f} class="w-full">
      <.psb-variation type="textarea" field={f[:field]} label="Label" placeholder="Placeholder" />
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
            <.psb-variation type="textarea" field={f[:field]} label="Label" placeholder="Placeholder" />
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
      %VariationGroup{
        id: :size,
        description: "Predefined sizes",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <.psb-variation type="textarea" field={f[:field]} placeholder="Placeholder" />
          </.form>
        """,
        variations:
          for size <- FormField.form_field_sizes() do
            %Variation{
              id: String.to_atom("size_#{size}"),
              attributes: %{
                size: size,
                label: "Size - #{size}"
              }
            }
          end
      },
      %Variation{
        id: :without_label,
        description: "Without label",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <.psb-variation type="textarea" field={f[:field]} placeholder="Placeholder" />
          </.form>
        """
      },
      %Variation{
        id: :without_placeholder,
        description: "Without placeholder",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <.psb-variation type="textarea" field={f[:field]} label="Label" />
          </.form>
        """
      }
    ]
end
