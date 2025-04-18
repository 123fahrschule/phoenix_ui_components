defmodule PhoenixUiComponents.DevTools do
  use Phoenix.Component

  import PhoenixUiComponents.Icon
  import PhoenixUiComponents.CustomLink

  attr :primary, :string, required: true
  attr :secondary, :string
  attr :icon, :any, default: :dashboard
  attr :status, :string, values: ["default", "warning", "error"]
  attr :errors_count, :integer, default: 0
  attr :warnings_count, :integer, default: 0
  attr :rest, :global, include: ["href", "navigate", "patch"]

  def dev_tools_navigation_item(assigns) do
    assigns =
      assigns
      |> assign_new(:status, &dev_tools_item_status/1)
      |> assign_new(:secondary, &secondary_text/1)

    ~H"""
    <li class="overflow-hidden text-body-sm">
      <.custom_link
        class={[
          "flex items-center gap-2 py-1.5 pl-3 pr-2 rounded-8 text-start outline-offset-[-2px] w-full border min-h-[50px]",
          dev_tools_item_color(@status),
          "hover:bg-neutral-800 focus:bg-neutral-800"
        ]}
        {@rest}
      >
        <div class="flex-shrink-0">
          <.icon outlined icon={devtools_icon(@status, @icon)} />
        </div>

        <div class="flex-grow">
          <p>
            {@primary}
          </p>

          <p :if={@secondary} class="text-body-xs">
            {@secondary}
          </p>
        </div>

        <div>
          <.icon outlined icon={:chevron_right} />
        </div>
      </.custom_link>
    </li>
    """
  end

  defp dev_tools_item_status(%{errors_count: errors_count}) when errors_count > 0,
    do: "error"

  defp dev_tools_item_status(%{warnings_count: warnings_count}) when warnings_count > 0,
    do: "warning"

  defp dev_tools_item_status(_),
    do: "default"

  defp dev_tools_item_color("warning"),
    do: "text-warning-300 border-warning-300 outline-warning-300 bg-neutral-900"

  defp dev_tools_item_color("error"),
    do: "text-error-400 border-error-400 outline-error-400 bg-error-300/[0.08]"

  defp dev_tools_item_color(_),
    do: "text-neutral-500 border-neutral-500 bg-neutral-900"

  defp devtools_icon("warning", _icon), do: :report_problem
  defp devtools_icon("error", _icon), do: :error_outline
  defp devtools_icon(_status, icon), do: icon

  defp secondary_text(%{errors_count: errors_count}) when errors_count > 0,
    do: "#{errors_count} Errors"

  defp secondary_text(%{warnings_count: warnings_count}) when warnings_count > 0,
    do: "#{warnings_count} Warnings"

  defp secondary_text(_),
    do: "0 Errors"
end
