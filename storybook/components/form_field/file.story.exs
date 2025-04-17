defmodule Storybook.Components.FormField.File do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.FormField

  def function, do: &FormField.form_field/1

  def template,
    do: """
    <.form for={%{}} :let={f} class="w-full">
      <.psb-variation type="file" field={f[:field]} label="File" placeholder="Placeholder" />
    </.form>
    """

  def variations,
    do: [
      %Variation{
        id: :default,
        description: "Default",
        attributes: %{
          accept: "image/*"
        }
      },
      %Variation{
        id: :error,
        description: "Error",
        template: """
          <.form for={%{}} as={:story} :let={f} class="w-full">
            <% f = %{f | params: %{"error"  => ""}, errors: [error: {"can't be blank", []}]} %>
            <.psb-variation type="file" field={f[:error]} label="Label" placeholder="Placeholder" />
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
            <.psb-variation type="file" field={f[:field]} placeholder="Placeholder" />
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
      }
    ]
end
