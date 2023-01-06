defmodule PhoenixUiComponents.Table do
  use PhoenixUiComponents, :component

  attr(:rows, :list, required: true)
  attr(:container_class, :string, default: nil)
  attr(:table_class, :string, default: nil)

  slot :col, required: true do
    attr(:label, :string)
  end

  slot(:action, doc: "the slot for showing user actions in the last table column")

  def table(assigns) do
    ~H"""
    <div class={[
      "overflow-hidden border border-neutral-300 rounded-2xl text-sm leading-tight",
      @container_class
    ]}>
      <table class={["w-full text-left bg-neutral-100", @table_class]}>
        <thead class="bg-neutral-200">
          <tr>
            <th :for={col <- @col} class="py-3 px-6">
              <%= col[:label] %>
            </th>
            <th :if={@action != []} class="w-px"></th>
          </tr>
        </thead>

        <tbody class="divide-y divide-neural-300">
          <tr :for={row <- @rows}>
            <td :for={{col, i} <- Enum.with_index(@col)} class="py-3 px-6">
              <%= render_slot(col, row) %>
            </td>
            <td :if={@action != []} class="px-6">
              <div class="flex items-center">
                <span :for={action <- @action}>
                  <%= render_slot(action, row) %>
                </span>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    """
  end
end
