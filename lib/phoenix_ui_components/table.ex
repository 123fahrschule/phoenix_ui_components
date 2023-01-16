defmodule PhoenixUiComponents.Table do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Card

  attr(:rows, :list, required: true)
  attr(:container_class, :string, default: nil)
  attr(:table_class, :string, default: nil)
  attr(:rest, :global)

  slot :col, required: true do
    attr(:label, :string)
    attr(:field, :any)
  end

  slot(:action, doc: "the slot for showing user actions in the last table column")

  def table(assigns) do
    ~H"""
    <.info_card class={List.flatten(["text-sm leading-tight", @container_class])} {@rest}>
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
            <td :for={col <- @col} class="py-3 px-6">
              <%= if col[:field] do %>
                <%= Map.get(row, col[:field]) %>
              <% else %>
                <%= render_slot(col, row) %>
              <% end %>
            </td>
            <td :if={@action != []} class="py-3 px-6">
              <div class="flex items-center space-x-2">
                <span :for={action <- @action}>
                  <%= render_slot(action, row) %>
                </span>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </.info_card>
    """
  end
end
