defmodule PhoenixUiComponents.Form do
  use PhoenixUiComponents, :component
  import Phoenix.HTML.Form

  # attr :form, :any, required: true
  # attr :field, :atom, required: true
  # attr :label, :string, default: nil
  # attr :placeholder, :string, default: nil
  # attr :class, :string, default: nil
  # attr :wrapper_class, :string, default: nil
  # attr :type, :string, default: "text"
  # attr :size, :string, default: "md", doc: ~s'Available options: "sm", "md", "lg"'
  # attr :rest, :global
  def text_field(assigns) do
    # TODO: Handle valid/invalid states
    assigns =
      assigns
      |> assign_class
      |> assign_attr(:wrapper_class)
      |> assign_attr(:label)
      |> assign_attr(:type, "text")
      |> assign_attr(:size, "md")
      |> assign_rest([:form, :field, :class, :wrapper_class, :label, :size])

    ~H"""
    <div class={@wrapper_class}>
      <%= label(@form, @field, @label,
        class: ["block text-neutral-900 font-semibold mb-1", get_text_size_classes(@size)]
      ) %>
      <div class="mb-1 group">
        <%= text_input(
          @form,
          @field,
          [
            class: [
              default_classes(),
              focus_classes(),
              disabled_classes(),
              get_text_size_classes(@size),
              get_input_size_classes(@size),
              @class
            ]
          ] ++ @rest
        ) %>
      </div>
    </div>
    """
  end

  # attr :form, :any, required: true
  # attr :field, :atom, required: true
  # attr :options, :list, required: true
  # attr :label, :string, default: nil
  # attr :placeholder, :string, default: nil
  # attr :class, :string, default: nil
  # attr :wrapper_class, :string, default: nil
  # attr :size, :string, default: "md", doc: ~s'Available options: "sm", "md", "lg"'
  # attr :rest, :global
  def select(%{native: true} = assigns) do
    assigns =
      assigns
      |> assign_class
      |> assign_attr(:wrapper_class)
      |> assign_attr(:label)
      |> assign_attr(:size, "md")
      |> assign_rest([:form, :field, :options, :class, :wrapper_class, :label, :size])

    ~H"""
    <div class={@wrapper_class}>
      <%= label(@form, @field, @label,
        class: ["block text-neutral-900 font-semibold mb-1", get_text_size_classes(@size)]
      ) %>
      <div class="mb-1 group">
        <%= select(
          @form,
          @field,
          @options,
          [
            class: [
              default_classes(),
              focus_classes(),
              disabled_classes(),
              get_text_size_classes(@size),
              get_input_size_classes(@size),
              @class
            ]
          ] ++ @rest
        ) %>
      </div>
    </div>
    """
  end

  # attr :form, :any, required: true
  # attr :field, :atom, required: true
  # attr :label, :string, default: nil
  # attr :wrapper_class, :string, default: nil
  # attr :size, :string, default: "md", doc: ~s'Available options: "sm", "md", "lg"'
  # attr :rest, :global
  def field_container(assigns) do
    assigns =
      assigns
      |> assign_class
      |> assign_attr(:wrapper_class)
      |> assign_attr(:label)
      |> assign_attr(:size, "md")
      |> assign_rest([:form, :field, :wrapper_class, :label, :size])

    ~H"""
    <div class={@wrapper_class}>
      <%= label(@form, @field, @label,
        class: ["block text-neutral-900 font-semibold mb-1", get_text_size_classes(@size)]
      ) %>
      <div class="mb-1 group">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  # attr :form, :any, required: true
  # attr :field, :atom, required: true
  # attr :class, :string, default: nil
  # attr :size, :string, default: "md", doc: ~s'Available options: "sm", "md", "lg"'
  # attr :rest, :global
  def file_input(assigns) do
    assigns =
      assigns
      |> assign_class
      |> assign_attr(:size, "md")
      |> assign_rest([:form, :field, :class, :size])

    ~H"""
    <%= file_input(
      @form,
      @field,
      [
        class: [
          "file:bg-neutral-400 file:px-4 file:py-2.5 file:rounded-full file:border-0 file:mr-4 file:cursor-pointer cursor-pointer pr-3",
          default_classes(),
          focus_classes(),
          focus_visible_classes(),
          disabled_classes(),
          get_text_size_classes(@size),
          get_file_button_size_classes(@size),
          @class
        ]
      ] ++ @rest
    ) %>
    """
  end

  # attr :form, :any, required: true
  # attr :field, :atom, required: true
  # attr :wrapper_class, :string, default: nil
  def date_select(assigns) do
    assigns =
      assigns
      |> assign_attr(:wrapper_class)
      |> assign_attr(:size, "md")
      |> assign_rest([:form, :field, :wrapper_class, :size])

    ~H"""
    <div class={["flex space-x-4", @wrapper_class]}>
      <%= date_select @form, @field, builder: fn b -> %>
        <%= b.(:day,
          class: [
            "bg-neutral-200 border rounded-full text-neutral-900 placeholder:text-neutral-600 border-neutral-300 shadow-input pl-6 pr-10 py-2.5",
            focus_classes(),
            disabled_classes(),
            get_text_size_classes(@size)
          ]
        ) %>
        <%= b.(:month,
          class: [
            "bg-neutral-200 border rounded-full text-neutral-900 placeholder:text-neutral-600 border-neutral-300 shadow-input pl-6 pr-10 py-2.5",
            focus_classes(),
            disabled_classes(),
            get_text_size_classes(@size)
          ]
        ) %>
        <%= b.(:year,
          class: [
            "bg-neutral-200 border rounded-full text-neutral-900 placeholder:text-neutral-600 border-neutral-300 shadow-input pl-6 pr-10 py-2.5",
            focus_classes(),
            disabled_classes(),
            get_text_size_classes(@size)
          ]
        ) %>
      <% end %>
    </div>
    """
  end

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
end
