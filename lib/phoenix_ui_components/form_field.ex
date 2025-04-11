defmodule PhoenixUiComponents.FormField do
  use Phoenix.Component

  @sizes ["sm", "md", "lg"]
  @types [
    "text",
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
    "select",
    "textarea",
    "hidden",
    "color"
    # TODO: add all possible types
    # "file",
    # "range"
    # "checkbox"
  ]
  @rest_attributes [
    "accept",
    "autocomplete",
    "capture",
    "cols",
    "form",
    "list",
    "max",
    "maxlength",
    "min",
    "minlength",
    "multiple",
    "pattern",
    "placeholder",
    "readonly",
    "required",
    "rows",
    "size",
    "step"
  ]

  # Tailwind safelist
  # form-field-label-sm form-field-label-md form-field-label-lg
  # form-field-input-sm form-field-input-md form-field-input-lg

  attr :id, :any, default: nil
  attr :name, :any
  attr :label, :string, default: nil
  attr :value, :any
  attr :type, :string, default: "text", values: @types

  attr :field, Phoenix.HTML.FormField,
    doc: "a form field struct retrieved from the form, for example: @form[:email]"

  attr :errors, :list, default: []
  # attr :checked, :boolean, doc: "the checked flag for checkbox inputs"
  attr :prompt, :string, default: nil, doc: "the prompt for select inputs"
  attr :options, :list, doc: "the options to pass to Phoenix.HTML.Form.options_for_select/2"
  attr :multiple, :boolean, default: false, doc: "the multiple flag for select inputs"
  attr :disabled, :boolean, default: false
  attr :size, :string, values: @sizes, default: "md"
  attr :class, :any, default: nil
  attr :input_class, :any, default: nil
  attr :rest, :global, include: @rest_attributes

  slot :input_content
  slot :label_content

  def form_field(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    errors = if Phoenix.Component.used_input?(field), do: field.errors, else: []

    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign(:errors, Enum.map(errors, &translate_error(&1)))
    |> assign_new(:name, fn -> if assigns.multiple, do: field.name <> "[]", else: field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> form_field()
  end

  def form_field(%{type: "select"} = assigns) do
    ~H"""
    <div class={["form-field", @class]}>
      <div class="relative w-full flex flex-col">
        <.form_field_label
          :if={@label || @label_content != []}
          for={@id}
          size={@size}
          disabled={@disabled}
        >
          <%= @label %>
          <%= render_slot(@label_content) %>
        </.form_field_label>
        <select
          id={@id}
          name={@name}
          multiple={@multiple}
          disabled={@disabled}
          class={[
            "form-field-input form-field-input-#{@size} select",
            @errors != [] && "form-field-input-error"
          ]}
          {@rest}
        >
          <option :if={@prompt} value=""><%= @prompt %></option>
          <%= Phoenix.HTML.Form.options_for_select(@options, @value) %>
        </select>
      </div>
      <.form_field_error :for={msg <- @errors}>
        <%= msg %>
      </.form_field_error>
    </div>
    """
  end

  def form_field(%{type: "textarea"} = assigns) do
    ~H"""
    <div class={["form-field", @class]}>
      <div class="relative w-full flex flex-col">
        <.form_field_label
          :if={@label || @label_content != []}
          for={@id}
          size={@size}
          disabled={@disabled}
        >
          <%= @label %>
          <%= render_slot(@label_content) %>
        </.form_field_label>
        <textarea
          id={@id}
          name={@name}
          disabled={@disabled}
          class={[
            "form-field-input form-field-input-#{@size}",
            @errors != [] && "form-field-input-error"
          ]}
          {@rest}
        ><%= Phoenix.HTML.Form.normalize_value("textarea", @value) %></textarea>
      </div>
      <.form_field_error :for={msg <- @errors}>
        <%= msg %>
      </.form_field_error>
    </div>
    """
  end

  def form_field(%{type: "hidden"} = assigns) do
    ~H"""
    <input
      type="hidden"
      id={@id}
      name={@name}
      disabled={@disabled}
      value={Phoenix.HTML.Form.normalize_value(@type, @value)}
      {@rest}
    />
    """
  end

  def form_field(assigns) do
    ~H"""
    <div class={["form-field", @class]}>
      <div class="relative w-full flex flex-col">
        <.form_field_label
          :if={@label || @label_content != []}
          for={@id}
          size={@size}
          disabled={@disabled}
        >
          <%= @label %>
          <%= render_slot(@label_content) %>
        </.form_field_label>
        <div class="relative">
          <input
            type={@type}
            id={@id}
            name={@name}
            disabled={@disabled}
            value={Phoenix.HTML.Form.normalize_value(@type, @value)}
            class={[
              "form-field-input form-field-input-#{@size}",
              @errors != [] && "form-field-input-error",
              @input_class
            ]}
            {@rest}
          />
          <%= render_slot(@input_content) %>
        </div>
      </div>
      <.form_field_error :for={msg <- @errors}>
        <%= msg %>
      </.form_field_error>
    </div>
    """
  end

  @doc """
  Renders a label.
  """
  attr :for, :string, default: nil
  attr :size, :string, values: @sizes, default: "md"
  attr :disabled, :boolean, default: false

  slot :inner_block, required: true

  def form_field_label(assigns) do
    ~H"""
    <label for={@for} class={["form-field-label form-field-label-#{@size}", @disabled && "disabled"]}>
      <%= render_slot(@inner_block) %>
    </label>
    """
  end

  @doc """
  Generates a generic error message.
  """
  attr :class, :any, default: nil
  slot :inner_block, required: true

  def form_field_error(assigns) do
    ~H"""
    <p class={["form-field-error", @class]}>
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    gettext_backend = Application.get_env(:phoenix_ui_components, :gettext_backend)
    errors_domain = Application.get_env(:phoenix_ui_components, :errors_domain, "errors")

    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # However the error messages in our forms and APIs are generated
    # dynamically, so we need to translate them by calling Gettext
    # with our gettext backend as first argument. Translations are
    # available in the errors.po file (as we use the "errors" domain).
    if count = opts[:count] do
      Gettext.dngettext(gettext_backend, errors_domain, msg, msg, count, opts)
    else
      Gettext.dgettext(gettext_backend, errors_domain, msg, opts)
    end
  end

  @doc """
  Translates the errors for a field from a keyword list of errors.
  """
  def translate_errors(errors, field) when is_list(errors) do
    for {^field, {msg, opts}} <- errors, do: translate_error({msg, opts})
  end

  def form_field_sizes, do: @sizes
end
