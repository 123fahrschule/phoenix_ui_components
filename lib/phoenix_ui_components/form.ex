defmodule PhoenixUiComponents.Form do
  use PhoenixUiComponents, :component

  @sizes ["sm", "md", "lg"]

  attr(:for, :string, default: nil)
  attr(:class, :string, default: nil)
  attr(:size, :string, values: @sizes, default: "md")
  slot(:inner_block)

  defp label(assigns) do
    ~H"""
    <label
      for={@for}
      class={["block text-neutral-900 font-semibold mb-1", get_text_size_classes(@size), @class]}
    >
      <%= render_slot(@inner_block) %>
    </label>
    """
  end

  attr(:form, :any, required: true)
  attr(:field, :atom, required: true)
  attr(:label, :string, default: nil)
  attr(:class, :string, default: nil)
  attr(:wrapper_class, :string, default: nil)
  attr(:type, :string, default: "text")

  attr(:size, :string, values: @sizes, default: "md", doc: ~s'Available options: "sm", "md", "lg"')

  attr(:rest, :global)

  def text_field(assigns) do
    assigns =
      assigns
      |> assign_new(:id, fn -> Map.get(assigns.form[assigns.field], :id) end)
      |> assign_new(:name, fn -> Map.get(assigns.form[assigns.field], :name) end)
      |> assign_new(:value, fn -> Map.get(assigns.form[assigns.field], :value) end)

    ~H"""
    <div class={@wrapper_class}>
      <.label :if={@label} for={@id} size={@size}>
        <%= @label %>
      </.label>

      <div class="mb-1 group">
        <input
          type={@type}
          id={@id}
          name={@name}
          value={@value}
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
      </div>
    </div>
    """
  end

  attr(:form, :any, required: true)
  attr(:field, :atom, required: true)
  attr(:options, :list, required: true)
  attr(:prompt, :string, default: nil)
  attr(:label, :string, default: nil)
  attr(:class, :string, default: nil)
  attr(:wrapper_class, :string, default: nil)
  attr(:native, :boolean, default: true)

  attr(:size, :string, values: @sizes, default: "md", doc: ~s'Available options: "sm", "md", "lg"')

  attr(:rest, :global)

  def select(assigns) do
    assigns =
      assigns
      |> assign_new(:id, fn -> Map.get(assigns.form[assigns.field], :id) end)
      |> assign_new(:name, fn -> Map.get(assigns.form[assigns.field], :name) end)
      |> assign_new(:value, fn -> Map.get(assigns.form[assigns.field], :value) end)

    ~H"""
    <div class={@wrapper_class}>
      <.label :if={@label} for={@id} size={@size}>
        <%= @label %>
      </.label>

      <div class="mb-1 group">
        <select
          id={@id}
          name={@name}
          class={[
            default_classes(),
            focus_classes(),
            disabled_classes(),
            get_text_size_classes(@size),
            get_input_size_classes(@size),
            @class
          ]}
          {@rest}
        >
          <option :if={@prompt} value=""><%= @prompt %></option>
          <%= Phoenix.HTML.Form.options_for_select(@options, @value) %>
        </select>
      </div>
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

  defp disabled_classes(),
    do:
      "disabled:bg-neutral-300 disabled:text-neutral-700 disabled:border-neutral-500 disabled:shadow-input-disabled"
end
