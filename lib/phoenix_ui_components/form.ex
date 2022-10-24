defmodule PhoenixUiComponents.Form do
  use PhoenixUiComponents, :component
  import Phoenix.HTML.Form

  attr(:rest, :global)

  slot(:inner_block, required: true)

  def field_container(assigns) do
    ~H"""
    <div {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)

  def input_container(assigns) do
    ~H"""
    <div class={["mb-1 group", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:form, :any, required: true)
  attr(:field, :atom, required: true)
  attr(:label, :string, default: nil)
  attr(:size, :string, values: ["sm", "md", "lg"], default: "md")

  def field_label(assigns) do
    ~H"""
    <%= label(@form, @field, @label,
      class: ["block text-neutral-900 font-semibold mb-1", get_text_size_classes(@size)]
    ) %>
    """
  end

  attr(:error, :string, default: nil)

  def field_error(assigns) do
    ~H"""
    <p class="text-error-300 text-[11px] leading-[1.09]">
      <%= @error %>
    </p>
    """
  end

  attr(:form, :any, required: true)
  attr(:field, :atom, required: true)
  attr(:label, :string, default: nil)
  attr(:class, :string, default: nil)
  attr(:container_attrs, :list, default: [])
  attr(:type, :string, values: ["text"], default: "text")
  attr(:size, :string, values: ["sm", "md", "lg"], default: "md")
  attr(:rest, :global)

  def form_field(assigns) do
    ~H"""
    <.field_container {@container_attrs}>
      <.field_label form={@form} field={@field} label={@label} size={@size} />
      <.input_container>
        <.field_input
          type={@type}
          form={@form}
          field={@field}
          size={@size}
          class={[
            default_classes(),
            focus_classes(),
            disabled_classes(),
            get_text_size_classes(@size),
            get_input_size_classes(@size),
            @class
          ]}
          {@rest}
        />
      </.input_container>
      <.field_error />
    </.field_container>
    """
  end

  attr(:type, :string, required: true)
  attr(:form, :any, required: true)
  attr(:field, :atom, required: true)
  attr(:size, :string, values: ["sm", "md", "lg"], default: "md")
  attr(:options, :list, default: [])
  attr(:rest, :global)

  def field_input(%{type: "text"} = assigns) do
    ~H"""
    <%= text_input(@form, @field, assigns_to_attributes(@rest)) %>
    """
  end

  def field_input(%{type: "email"} = assigns) do
    ~H"""
    <%= email_input(@form, @field, assigns_to_attributes(@rest)) %>
    """
  end

  def field_input(%{type: "password"} = assigns) do
    ~H"""
    <%= password_input(@form, @field, assigns_to_attributes(@rest)) %>
    """
  end

  def field_input(%{type: "number"} = assigns) do
    ~H"""
    <%= number_input(@form, @field, assigns_to_attributes(@rest)) %>
    """
  end

  def field_input(%{type: "textarea"} = assigns) do
    assigns =
      assigns
      |> assign_new(:class, fn assigns -> assigns.rest.class end)

    ~H"""
    <%= textarea(
      @form,
      @field,
      [
        class:
          List.flatten([
            get_textarea_size_classes(@size),
            @class
          ])
      ] ++ assigns_to_attributes(@rest)
    ) %>
    """
  end

  def field_input(%{type: "select"} = assigns) do
    ~H"""
    <%= select(@form, @field, @options, assigns_to_attributes(@rest)) %>
    """
  end

  def field_input(%{type: "file"} = assigns) do
    ~H"""
    <%= file_input(
      @form,
      @field,
      [
        class: [
          "file:bg-neutral-400 file:px-4 file:py-2.5 file:rounded-full file:border-0 file:mr-4 file:cursor-pointer cursor-pointer pr-3",
          get_file_button_size_classes(@size)
        ]
      ] ++ assigns_to_attributes(@rest)
    ) %>
    """
  end

  def field_input(%{type: "date_select"} = assigns) do
    ~H"""
    <div class={["flex space-x-4"]}>
      <%= date_select @form, @field, builder: fn b -> %>
        <%= b.(:day,
          class: [
            "bg-neutral-200 border rounded-full text-neutral-900 placeholder:text-neutral-600 border-neutral-300 shadow-input pl-6 pr-10",
            focus_classes(),
            disabled_classes(),
            get_input_vertical_size_classes(@size),
            get_text_size_classes(@size)
          ]
        ) %>
        <%= b.(:month,
          class: [
            "bg-neutral-200 border rounded-full text-neutral-900 placeholder:text-neutral-600 border-neutral-300 shadow-input pl-6 pr-10",
            focus_classes(),
            disabled_classes(),
            get_input_vertical_size_classes(@size),
            get_text_size_classes(@size)
          ]
        ) %>
        <%= b.(:year,
          class: [
            "bg-neutral-200 border rounded-full text-neutral-900 placeholder:text-neutral-600 border-neutral-300 shadow-input pl-6 pr-10",
            focus_classes(),
            disabled_classes(),
            get_input_vertical_size_classes(@size),
            get_text_size_classes(@size)
          ]
        ) %>
      <% end %>
    </div>
    """
  end

  defp get_input_vertical_size_classes("sm"), do: "py-2"
  defp get_input_vertical_size_classes("md"), do: "py-2.5"
  defp get_input_vertical_size_classes("lg"), do: "py-3"

  defp get_input_size_classes("sm"), do: "px-3 py-2"
  defp get_input_size_classes("md"), do: "px-4 py-2.5"
  defp get_input_size_classes("lg"), do: "px-5 py-3"

  defp get_text_size_classes("sm"), do: "text-xs leading-[1.334]"
  defp get_text_size_classes("md"), do: "text-sm leading-[1.429]"
  defp get_text_size_classes("lg"), do: "text-base leading-normal"

  defp default_classes(),
    do:
      "w-full bg-neutral-200 border rounded-full text-neutral-900 placeholder:text-neutral-600 border-neutral-300 shadow-input"

  defp focus_classes(),
    do: "focus:border-primary-300 focus:ring-primary-300 focus:shadow-input-focus"

  defp focus_visible_classes(),
    do:
      "focus-visible:border-primary-300 focus-visible:outline-primary-300 focus-visible:shadow-input-focus"

  defp disabled_classes(),
    do:
      "disabled:bg-neutral-300 disabled:text-neutral-700 disabled:border-neutral-500 disabled:shadow-input-disabled"

  defp success_classes(),
    do: "valid:border-success-300 valid:bg-success-100 valid:shadow-input-success"

  defp error_classes(),
    do:
      "invalid:border-error-300 invalid:bg-error-100 invalid:shadow-input-error invalid:shadow-input-error"

  defp get_file_button_size_classes("sm"), do: "file:py-2"
  defp get_file_button_size_classes("md"), do: "file:py-2.5"
  defp get_file_button_size_classes("lg"), do: "file:py-3"

  def get_textarea_size_classes("sm"), do: "!rounded-lg"
  def get_textarea_size_classes("md"), do: "!rounded-2xl"
  def get_textarea_size_classes("lg"), do: "!rounded-3xl"
end
