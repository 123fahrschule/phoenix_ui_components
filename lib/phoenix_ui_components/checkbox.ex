defmodule PhoenixUiComponents.Checkbox do
  use PhoenixUiComponents, :component

  attr(:form, :any, required: true)
  attr(:field, :atom, required: true)
  attr(:label, :string, required: true)
  attr(:class, :string, default: nil)

  def checkbox(assigns) do
    assigns =
      assigns
      |> assign_new(:id, fn -> Map.get(assigns.form[assigns.field], :id) end)
      |> assign_new(:name, fn -> Map.get(assigns.form[assigns.field], :name) end)
      |> assign_new(:value, fn -> Map.get(assigns.form[assigns.field], :value) end)

    ~H"""
    <div class={["relative flex items-start", @class]}>
      <input
        type="checkbox"
        id={@id}
        name={@name}
        class="peer h-4 w-4 rounded border-2 border-neutral-700 text-primary-300 focus:ring-primary-300 mr-3 cursor-pointer"
      />
      <label
        :if={@label}
        for={@id}
        class="text-sm cursor-pointer text-neutral-700 peer-checked:font-semibold peer-checked:text-neutral-900"
      >
        <%= @label %>
      </label>
    </div>
    """
  end
end
