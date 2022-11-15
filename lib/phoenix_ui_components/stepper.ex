defmodule PhoenixUiComponents.Stepper do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Icon

  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block)

  def stepper(assigns) do
    ~H"""
    <div class={["flex", @class]} {@rest}><%= render_slot(@inner_block) %></div>
    """
  end

  attr(:label, :string, default: nil)
  attr(:index, :integer, required: true)
  attr(:state, :string, values: ["inactive", "active", "completed"], default: "inactive")
  attr(:rest, :global)

  def step(%{state: "inactive"} = assigns) do
    ~H"""
    <div class={[
      "relative flex-1 flex items-center justify-center pt-1 pb-3 px-4",
      get_border_classes(@state)
    ]}>
      <div class="h-6 w-6 border border-neutral-900 rounded-full bg-neutral-200 text-center text-neutral-900 text-sm font-semibold mr-2">
        <%= @index %>
      </div>
      <span class="text-sm font-semibold">
        <%= @label %>
      </span>
    </div>
    """
  end

  def step(%{state: "active"} = assigns) do
    ~H"""
    <div class={[
      "relative flex-1 flex items-center justify-center pt-1 pb-3 px-4",
      get_border_classes(@state)
    ]}>
      <div class="h-6 w-6 border border-neutral-100 rounded-full bg-secondary-300 text-center text-neutral-100 text-sm font-semibold mr-2">
        <%= @index %>
      </div>
      <span class="text-sm font-semibold">
        <%= @label %>
      </span>
    </div>
    """
  end

  def step(%{state: "completed"} = assigns) do
    ~H"""
    <div class={[
      "relative flex-1 flex items-center justify-center pt-1 pb-3 px-4",
      get_border_classes(@state)
    ]}>
      <div class="h-6 w-6 flex items-center justify-center border border-secondary-300 rounded-full bg-neutral-100 mr-2">
        <.icon icon={:check} class="text-[16px] text-secondary-300" />
      </div>
      <span class="text-sm font-semibold">
        <%= @label %>
      </span>
    </div>
    """
  end

  defp get_border_classes("inactive"),
    do: "after:border-b after:border-neutral-300 after:absolute after:bottom-0 after:w-full"

  defp get_border_classes(_),
    do: "after:border-b-2 after:border-secondary-300 after:absolute after:bottom-0 after:w-full"
end
