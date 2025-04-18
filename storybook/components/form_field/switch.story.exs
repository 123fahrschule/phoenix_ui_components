defmodule Storybook.Components.FormField.Switch do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.FormField

  def function, do: &FormField.form_field/1

  def template,
    do: """
    <.form for={%{}} :let={f} class="w-full">
      <.psb-variation type="switch" field={f[:field]} label="Label" />
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
            <% f = %{f | params: %{"error"  => ""}, errors: [error: {"can't be blank", []}]} %>
            <.psb-variation type="switch" field={f[:error]} label="Label"/>
          </.form>
        """
      },
      %VariationGroup{
        id: :disabled,
        description: "Disabled",
        variations: [
          %Variation{
            id: :default,
            attributes: %{
              disabled: true
            }
          },
          %Variation{
            id: :checked,
            attributes: %{
              disabled: true,
              checked: true
            }
          }
        ]
      },
      %Variation{
        id: :with_icon,
        description: "With icon",
        attributes: %{
          switch_icon: true
        }
      },
      %VariationGroup{
        id: :size,
        description: "Predefined sizes",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <.psb-variation type="switch" field={f[:field]} label="Label" />
          </.form>
        """,
        variations:
          for size <- ["md", "lg"] do
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
        id: :custom_label,
        description: "Custom label content",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <.psb-variation type="switch" field={f[:custom_label]}/>
          </.form>
        """,
        slots: [
          """
          <p>
            Allow notifications
          </p>
          """
        ]
      },
      %Variation{
        id: :without_label,
        description: "Without label",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <.psb-variation type="switch" field={f[:without_label]}/>
          </.form>
        """
      },
      %Variation{
        id: :legacy,
        description: "Legacy form",
        attributes: %{
          label: "Legacy form"
        },
        template: """
        <.form for={%{}} :let={f} class="w-full">
          <.psb-variation type="switch" form={f} field={:legacy} />
        </.form>
        """
      }
    ]
end
