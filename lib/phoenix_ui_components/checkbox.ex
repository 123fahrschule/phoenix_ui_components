defmodule PhoenixUiComponents.Checkbox do
  use PhoenixUiComponents, :component
  import Phoenix.HTML.Form

  # attr :form, :any, required: true
  # attr :field, :atom, required: true
  # attr :label, :string, required: true
  # attr :class, :string, default: nil
  def checkbox(assigns) do
    assigns =
      assigns
      |> assign_class

    ~H"""
    <div class={["relative flex items-start", @class]}>
      <%= checkbox(@form, @field,
        class:
          "peer h-4 w-4 rounded border-2 border-neutral-700 text-primary-300 focus:ring-primary-300 mr-3 cursor-pointer"
      ) %>
      <%= label(@form, @field, @label,
        class:
          "text-sm cursor-pointer text-neutral-700 peer-checked:font-semibold peer-checked:text-neutral-900"
      ) %>
    </div>
    """
  end
end
