defmodule Storybook.Components.FormField.RadioGroup do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.FormField

  def function, do: &FormField.radio_group/1

  def layout, do: :one_column

  def imports,
    do: [
      {FormField, form_field: 1}
    ]

  def(variations,
    do: [
      %Variation{
        id: :default,
        description: "Default",
        template: """
        <.form for={%{}} :let={f} class="w-full">
          <.psb-variation label="Please select" field={f[:default]} />
        </.form>
        """,
        slots: [
          """
          <div class="flex gap-2">
            <.form_field type="radio" field={f[:default]} value="one" label="Label one" />
            <.form_field type="radio" field={f[:default]} value="two" label="Label two" />
            <.form_field type="radio" field={f[:default]} value="three" label="Label three" />
          </div>
          """
        ]
      },
      %Variation{
        id: :error,
        description: "Error",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <% f = %{f | params: %{"error"  => ""}, errors: [error: {"can't be blank", []}]} %>
            <.psb-variation field={f[:error]} label="Please select" />
          </.form>
        """,
        slots: [
          """
          <div class="flex gap-2">
            <.form_field type="radio" field={f[:error]} value="one" label="Label one" />
            <.form_field type="radio" field={f[:error]} value="two" label="Label two" />
            <.form_field type="radio" field={f[:error]} value="three" label="Label three" />
          </div>
          """
        ]
      },
      %Variation{
        id: :disabled,
        description: "Disabled",
        attributes: %{
          disabled: true
        },
        template: """
        <.form for={%{}} :let={f} class="w-full">
          <.psb-variation label="Please select" field={f[:disabled]} />
        </.form>
        """,
        slots: [
          """
          <div class="flex gap-2">
            <.form_field disabled type="radio" field={f[:disabled]} value="one" label="Label one" />
            <.form_field disabled type="radio" field={f[:disabled]} value="two" label="Label two" />
            <.form_field disabled type="radio" field={f[:disabled]} value="three" label="Label three" />
          </div>
          """
        ]
      },
      %Variation{
        id: :custom_label,
        description: "Custom styles",
        template: """
          <.form for={%{}} :let={f} class="w-full">
            <.psb-variation label="Please select" field={f[:custom]}/>
          </.form>
        """,
        slots: [
          """
          <div class="flex flex-col gap-2">
            <.form_field type="radio" field={f[:custom]} value="one">
              Label <span class="text-secondary-400">one</span>
            </.form_field>
            <.form_field type="radio" field={f[:custom]} value="two">
              Label <span class="text-success-400">two</span>
            </.form_field>
            <.form_field type="radio" field={f[:custom]} value="three">
              Label <span class="text-info-400">three</span>
            </.form_field>
          </div>
          """
        ]
      },
      %Variation{
        id: :legacy,
        description: "Legacy form",
        template: """
        <.form for={%{}} :let={f} class="w-full">
          <.psb-variation label="Legacy form" field={f[:legacy]} />
        </.form>
        """,
        slots: [
          """
          <div class="flex gap-2">
            <.form_field type="radio" form={f} field={:legacy} value="one" label="Label one" />
            <.form_field type="radio" form={f} field={:legacy} value="two" label="Label two" />
            <.form_field type="radio" form={f} field={:legacy} value="three" label="Label three" />
          </div>
          """
        ]
      }
    ]
  )
end
