defmodule PhoenixUiComponents.Form do
  use PhoenixUiComponents, :component
  import Phoenix.HTML.Form
  import PhoenixUiComponents.Icon

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

  slot(:inner_block, required: true)

  def input_container(assigns) do
    ~H"""
    <div class={["mb-1 group relative", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:form, :any, required: true)
  attr(:field, :atom, required: true)
  attr(:label, :string, default: nil)
  attr(:size, :string, values: ["sm", "md", "lg"], default: "md")

  slot(:secondary_label)

  def field_label(assigns) do
    ~H"""
    <%= label @form, @field, class: ["block text-neutral-900 font-semibold mb-1", get_text_size_classes(@size)] do %>
      <%= @label %>
      <span :if={@secondary_label != []} class="text-xs text-neutral-600 font-normal">
        <%= render_slot(@secondary_label) %>
      </span>
    <% end %>
    """
  end

  attr(:class, :string, default: nil)
  attr(:error_message, :string, default: nil)
  attr(:rest, :global)

  def field_error(assigns) do
    ~H"""
    <p class={["text-error-300 text-[11px] leading-[1.09]", @class]} {@rest}>
      <%= @error_message %>
    </p>
    """
  end

  attr(:form, :any, required: true)
  attr(:field, :atom, required: true)
  attr(:label, :string, default: nil)
  attr(:class, :string, default: nil)
  attr(:container_attrs, :list, default: [])

  attr(:type, :string,
    values: [
      "text",
      "email",
      "password",
      "number",
      "textarea",
      "select",
      "file",
      "date_select",
      "date"
    ],
    default: "text"
  )

  attr(:size, :string, values: ["sm", "md", "lg"], default: "md")
  attr(:error_message, :string, default: nil)
  attr(:state, :string, values: ["default", "success", "error"], default: "default")
  attr(:left_icon, :atom, default: nil)
  attr(:right_icon, :atom, default: nil)
  attr(:left_icon_attrs, :list, default: [])
  attr(:right_icon_attrs, :list, default: [])
  attr(:error_attrs, :list, default: [])

  attr(:rest, :global,
    include: [
      "required",
      "disabled",
      "checked",
      "options",
      "min",
      "max",
      "step",
      "name",
      "accept"
    ]
  )

  slot(:secondary_label)

  def form_field(assigns) do
    ~H"""
    <.field_container {@container_attrs}>
      <.field_label form={@form} field={@field} label={@label} size={@size}>
        <:secondary_label :if={@secondary_label != []}>
          <%= render_slot(@secondary_label) %>
        </:secondary_label>
      </.field_label>
      <.input_container>
        <div class={[
          "flex items-center justify-center absolute top-0 bottom-0 left-3",
          get_icon_state_classes(@state),
          get_icon_size_classes(@size)
        ]}>
          <.icon :if={@left_icon} icon={@left_icon} {@left_icon_attrs} />
        </div>
        <.field_input
          type={@type}
          form={@form}
          field={@field}
          size={@size}
          class={
            List.flatten([
              get_input_classes(@size, @state),
              if(@left_icon, do: "!pl-10"),
              if(@right_icon, do: "!pr-10"),
              @class
            ])
          }
          {@rest}
        />
        <div class={[
          "flex items-center justify-center absolute top-0 bottom-0 right-3",
          get_icon_state_classes(@state),
          get_icon_size_classes(@size)
        ]}>
          <.icon :if={@right_icon} icon={@right_icon} {@right_icon_attrs} />
        </div>
      </.input_container>
      <.field_error :if={@error_message} error_message={@error_message} {@error_attrs} />
    </.field_container>
    """
  end

  attr(:type, :string, required: true)
  attr(:form, :any, required: true)
  attr(:field, :atom, required: true)
  attr(:size, :string, values: ["sm", "md", "lg"], default: "md")
  attr(:options, :list, default: [])

  attr(:rest, :global, include: ["value", "required", "disabled", "checked", "min", "max", "step"])

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
      ] ++ assigns_to_attributes(@rest, [:class])
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

  def field_input(%{type: "date"} = assigns) do
    ~H"""
    <%= date_input(@form, @field, assigns_to_attributes(@rest)) %>
    """
  end

  attr(:class, :string, default: nil)
  attr(:label, :string, default: nil)
  attr(:size, :string, values: ["sm", "md"], default: "md")
  attr(:close_button_attrs, :list, default: [])

  def tag(assigns) do
    ~H"""
    <div class={[
      "rounded-full inline-flex items-center bg-neutral-300 text-sm text-neutral-700 font-semibold",
      get_tag_size_classes(@size),
      @class
    ]}>
      <span class="text-ellipsis overflow-hidden">
        <%= @label %>
      </span>
      <button class="leading-[0] ml-1" {@close_button_attrs}>
        <.icon icon={:close} class="text-[16px]" />
      </button>
    </div>
    """
  end

  attr(:form, :any, required: true)
  attr(:field, :atom, required: true)
  attr(:options, :list, required: true)
  attr(:selected, :list, default: [])
  attr(:label, :string, default: nil)
  attr(:placeholder, :string, default: "")
  attr(:class, :string, default: nil)
  attr(:container_attrs, :list, default: [])
  attr(:size, :string, values: ["sm", "md", "lg"], default: "md")
  attr(:error_message, :string, default: nil)
  attr(:state, :string, values: ["default", "success", "error"], default: "default")
  attr(:scroll_options_into_view, :boolean, default: true)

  attr(:rest, :global)

  def multiselect(assigns) do
    ~H"""
    <.field_container
      x-data={"multiselect({scrollOptionsIntoView :#{@scroll_options_into_view}})"}
      {@container_attrs}
    >
      <%= multiple_select(@form, @field, @options,
        class: "hidden",
        "x-model": "selectedValues",
        selected: @selected
      ) %>

      <div class="relative">
        <%= label(@form, @field, @label, class: "block text-neutral-900 font-semibold mb-1 text-sm") %>
        <div class="mb-2">
          <button
            x-bind="toggler"
            type="button"
            class={[
              get_state_classes(@state),
              focus_classes(),
              focus_visible_classes(),
              disabled_classes(),
              "w-full border rounded-[24px] relative text-left pl-4 pr-8 ",
              @class
            ]}
            x-bind:class="tags.length === 0 ? 'py-3' : 'py-2'"
          >
            <span x-show="tags.length === 0" class="inline-block h-[1em]">
              <%= @placeholder %>
            </span>

            <div class="flex flex-wrap gap-x-1 gap-y-2">
              <template x-for="tag in tags">
                <div class="max-w-full rounded-full inline-flex items-center bg-neutral-300 text-sm text-neutral-700 font-semibold py-1.5 pl-4 pr-2 mr-1">
                  <span x-text="tag.label" class="text-ellipsis overflow-hidden" />
                  <button
                    @click.stop="deselectOption(tag.value)"
                    type="button"
                    class="leading-[0] ml-1"
                  >
                    <.icon icon={:close} class="text-[16px]" />
                  </button>
                </div>
              </template>
            </div>

            <div class={[
              "flex items-center justify-center absolute top-0 bottom-0 right-3",
              get_icon_state_classes(@state),
              get_icon_size_classes(@size)
            ]}>
              <.icon icon={:keyboard_arrow_down} class="text-primary-300 text-[24px]" />
            </div>
          </button>
        </div>

        <div
          x-bind="panel"
          x-on:click.away="close"
          x-on:keyup.escape.window="close"
          x-cloak
          class="w-full absolute z-10"
        >
          <div class="bg-neutral-100 border border-neutral-300 rounded-2xl shadow-[0px_4px_12px_-4px_rgba(31,41,51,0.16)] p-2">
            <input
              x-model.debounce="filterString"
              class={
                List.flatten([get_input_classes(@size, @state), focus_visible_classes(), "mb-2"])
              }
            />
            <div class="max-h-72 overflow-auto">
              <template x-for="group in filteredOptionsGroups">
                <div class="border-b-2 last:border-b-0">
                  <template x-if="group.label">
                    <button
                      x-on:click="toggleGroup(group)"
                      type="button"
                      class="w-full px-3 py-4 text-left text-sm font-semibold rounded-lg bg-neutral-100 hover:bg-neutral-200 group focus-visible:outline-0 focus-visible:bg-neutral-200"
                    >
                      <span x-text="group.label" />
                    </button>
                  </template>
                  <template x-for="option in group.options">
                    <button
                      type="button"
                      class="flex items-center justify-between w-full px-3 py-4 text-sm rounded-lg bg-neutral-100 hover:bg-neutral-200 group focus-visible:outline-0 focus-visible:bg-neutral-200"
                      x-on:click="toggleOption(option.value)"
                      x-bind:class="selectedValues.includes(option.value) && 'selected'"
                    >
                      <span x-text="option.label" />
                      <.icon
                        icon={:check}
                        class="text-[16px] ml-2 text-primary-300 hidden group-selected:inline-block"
                      />
                    </button>
                  </template>
                </div>
              </template>
            </div>
          </div>
          <div class="h-6" />
        </div>
      </div>
    </.field_container>
    """
  end

  def get_input_classes(size, state) do
    [
      get_default_classes(),
      get_state_classes(state),
      focus_classes(),
      disabled_classes(),
      get_text_size_classes(size),
      get_input_size_classes(size)
    ]
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

  defp get_default_classes(), do: "w-full border rounded-full"

  defp get_state_classes("success"),
    do:
      "border-success-300 bg-success-100 shadow-input-success focus:border-success-300 focus:ring-success-300"

  defp get_state_classes("error"),
    do:
      "border-error-300 bg-error-100 shadow-input-error shadow-input-error focus:border-error-300 focus:ring-error-300"

  defp get_state_classes(_),
    do:
      "bg-neutral-200 text-neutral-900 placeholder:text-neutral-600 border-neutral-300 shadow-input focus:border-primary-300 focus:ring-primary-300"

  defp focus_classes(),
    do: " focus:shadow-input-focus"

  def focus_visible_classes(),
    do:
      "focus-visible:border-primary-300 focus-visible:outline-primary-300 focus-visible:shadow-input-focus"

  defp disabled_classes(),
    do:
      "disabled:bg-neutral-300 disabled:text-neutral-700 disabled:border-neutral-500 disabled:shadow-input-disabled"

  defp get_file_button_size_classes("sm"), do: "file:py-2"
  defp get_file_button_size_classes("md"), do: "file:py-2.5"
  defp get_file_button_size_classes("lg"), do: "file:py-3"

  def get_textarea_size_classes("sm"), do: "!rounded-lg"
  def get_textarea_size_classes("md"), do: "!rounded-2xl"
  def get_textarea_size_classes("lg"), do: "!rounded-3xl"

  defp get_tag_size_classes("sm"), do: "py-1 pl-3 pr-2"
  defp get_tag_size_classes("md"), do: "py-1.5 pl-4 pr-2"

  def get_icon_size_classes("sm"), do: "text-[16px]"
  def get_icon_size_classes(_), do: "text-[24px]"

  def get_icon_state_classes("success"), do: "text-primary-300"
  def get_icon_state_classes("error"), do: "text-error-300"
  def get_icon_state_classes(_), do: "text-primary-300"
end
