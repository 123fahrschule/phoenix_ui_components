defmodule Storybook.Components.FormField.NativeSelect do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.FormField

  def function, do: &FormField.form_field/1

  def template,
    do: """
    <.form for={%{}} :let={f} class="w-full">
      <.psb-variation type="select" field={f[:field]} label="Label" prompt="Please select" options={[foo: "foo", bar: "bar"]} />
    </.form>
    """

  def variations,
    do: [
      %Variation{
        id: :default,
        description: "Default"
      },
      %Variation{
        id: :erorr,
        description: "Error",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <% f = %{f | params: %{"field"  => ""}, errors: [field: {"can't be blank", []}]} %>
            <.psb-variation type="select" field={f[:field]} label="Label" prompt="Please select" options={[foo: "foo", bar: "bar"]} />
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
            <.psb-variation type="select" field={f[:field]} prompt="Please select" options={[foo: "foo", bar: "bar"]} />
          </.form>
        """,
        variations:
          for size <- FormField.form_field_sizes() do
            %Variation{
              id: String.to_atom("size_#{size}"),
              attributes: %{
                size: size,
                label: "Size #{size}"
              }
            }
          end
      },
      %Variation{
        id: :without_label,
        description: "Without label",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <.psb-variation type="select" field={f[:field]} prompt="Please select" options={[foo: "foo", bar: "bar"]} />
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
          <.psb-variation type="select" form={f} field={:legacy} prompt="Please select" options={[foo: "foo", bar: "bar"]} />
        </.form>
        """
      }
    ]
end
