defmodule PhoenixUiComponents.MultiselectAlpine do
  # TODO: Replace with LivView implementation
  use PhoenixUiComponents, :component

  import PhoenixUiComponents.Icon

  attr :form, :any, required: true
  attr :field, :atom, required: true
  attr :options, :list, required: true
  attr :selected, :list, default: []
  attr :label, :string, default: nil
  attr :placeholder, :string, default: ""
  attr :class, :any, default: nil
  attr :container_attrs, :list, default: []
  attr :size, :string, values: ["sm", "md", "lg"], default: "md"
  attr :error_message, :string, default: nil
  attr :state, :string, values: ["default", "success", "error"], default: "default"
  attr :scroll_options_into_view, :boolean, default: true

  attr :rest, :global

  def multiselect(assigns) do
    field = assigns.form[assigns.field]

    assigns =
      assigns
      |> assign_new(:id, field.id)
      |> assign_new(:name, fn -> field.name <> "[]" end)
      |> assign_new(:value, fn -> field.value end)

    ~H"""
    <div
      x-data={"multiselect({scrollOptionsIntoView :#{@scroll_options_into_view}})"}
      {@container_attrs}
      {@rest}
    >
      <select id={@id} name={@name} multiple class="hidden" x-model="selectedValues">
        {Phoenix.HTML.Form.options_for_select(@options, @value)}
      </select>

      <div class="relative">
        <label for={@id} class="block text-neutral-900 font-semibold mb-1 text-sm">
          {@label}
        </label>
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
              {@placeholder}
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
              class={[get_input_classes(@size, @state), focus_visible_classes(), "mb-2"]}
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
    </div>
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

  def get_icon_size_classes("sm"), do: "text-[16px]"
  def get_icon_size_classes(_), do: "text-[24px]"

  def get_icon_state_classes("success"), do: "text-primary-300"
  def get_icon_state_classes("error"), do: "text-error-300"
  def get_icon_state_classes(_), do: "text-primary-300"
end
