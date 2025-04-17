defmodule Storybook.Components.FormField.FormField do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.FormField
  alias PhoenixUiComponents.Icon
  alias PhoenixUiComponents.Tooltip

  def imports,
    do: [
      {Icon, icon: 1},
      {Tooltip, tooltip: 1}
    ]

  def function, do: &FormField.form_field/1

  def template,
    do: """
    <.form for={%{}} :let={f} class="w-full">
      <.psb-variation field={f[:field]} label="Label" placeholder="Placeholder" />
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
          <.form for={%{}} as={:story} :let={f} class="w-full">
            <% f = %{f | params: %{"field"  => ""}, errors: [field: {"can't be blank", []}]} %>
            <.psb-variation field={f[:field]} label="Label" placeholder="Placeholder" />
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
            <.psb-variation field={f[:field]} placeholder="Placeholder" />
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
      %VariationGroup{
        id: :different_types,
        description: "Different types",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <.psb-variation field={f[:field]} placeholder="Placeholder" />
          </.form>
        """,
        variations:
          for type <- [
                # "text",
                "email",
                "password",
                "number",
                "date",
                "month",
                "week",
                "time",
                "datetime-local",
                "search",
                "tel",
                "url",
                "range"
              ] do
            %Variation{
              id: String.to_atom("type_#{type}"),
              attributes: %{
                type: type,
                label: type
              }
            }
          end
      },
      %Variation{
        id: :without_label,
        description: "Without label",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <.psb-variation field={f[:field]} placeholder="Placeholder" />
          </.form>
        """
      },
      %Variation{
        id: :without_placeholder,
        description: "Without placeholder",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <.psb-variation field={f[:field]} label="Label" />
          </.form>
        """
      },
      %Variation{
        id: :tooltip,
        description: "Tooltip",
        attributes: %{
          label: "Label with tooltip",
          placeholder: "Field placeholder"
        },
        template: """
        <.form for={%{}} :let={f} class="w-full">
          <.psb-variation field={f[:field]} />
        </.form>
        """,
        slots: [
          """
          <:label_content>
            <.icon icon={:help} class="text-[14px] text-primary-400" />
            <.tooltip text="Expalnation text" />
          </:label_content>
          """
        ]
      },
      %Variation{
        id: :legacy,
        description: "Legacy form",
        attributes: %{
          label: "Legacy form"
        },
        template: """
        <.form for={%{}} :let={f} class="w-full">
          <.psb-variation form={f} field={:legacy} />
        </.form>
        """
      }
    ]
end
