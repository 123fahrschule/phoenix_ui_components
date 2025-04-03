defmodule PhoenixUiComponents.Table do
  use PhoenixUiComponents, :component

  import PhoenixUiComponents.Dropdown
  import PhoenixUiComponents.Icon

  alias Phoenix.LiveView.JS

  attr(:rows, :list, default: nil)
  attr(:container_class, :string, default: nil)
  attr(:table_class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block)

  slot :col do
    attr(:label, :string)
    attr(:field, :any)
  end

  slot(:action, doc: "the slot for showing user actions in the last table column")

  def table(%{rows: nil} = assigns) do
    ~H"""
    <div class={["table-container", @container_class]} {@rest}>
      <table class={["", @table_class]}>
        <%= render_slot(@inner_block) %>
      </table>
    </div>
    """
  end

  def table(assigns) do
    ~H"""
    <div class={["table-container", @container_class]} {@rest}>
      <table class={["", @table_class]}>
        <thead>
          <tr>
            <th :for={col <- @col}>
              <div class="table-label">
                <%= col[:label] %>
              </div>
            </th>
            <th :if={@action != []}></th>
          </tr>
        </thead>

        <tbody>
          <tr :for={row <- @rows}>
            <td :for={col <- @col}>
              <%= if col[:field] do %>
                <%= Map.get(row, col[:field]) %>
              <% else %>
                <%= render_slot(col, row) %>
              <% end %>
            </td>
            <td :if={@action != []}>
              <div class="flex items-center space-x-2">
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

  attr(:ordered_by, :string, default: nil)
  attr(:direction, :string, default: nil)

  attr(:on_sort, :any,
    default: nil,
    doc: "JS command executed on sorting change"
  )

  attr(:rest, :global)

  slot(:inner_block)

  slot :th do
    attr(:label, :string)
    attr(:sort_field, :any)
  end

  def thead(%{th: []} = assigns) do
    ~H"""
    <thead {@rest}>
      <%= render_slot(@inner_block) %>
    </thead>
    """
  end

  def thead(assigns) do
    ~H"""
    <thead {@rest}>
      <.tr>
        <%= for header <- @th do %>
          <%= case header do %>
            <% %{label: label } when not is_nil(label) -> %>
              <.th
                field={header[:field]}
                on_sort={@on_sort}
                direction={@direction}
                ordered_by={@ordered_by}
              >
                <%= label %>
              </.th>
            <% _ -> %>
              <.th />
          <% end %>
        <% end %>
      </.tr>
    </thead>
    """
  end

  attr(:rest, :global)

  slot(:inner_block)

  def tr(assigns) do
    ~H"""
    <tr {@rest}>
      <%= render_slot(@inner_block) %>
    </tr>
    """
  end

  attr(:ordered_by, :string, default: nil)
  attr(:direction, :string)
  attr(:field, :string, default: nil)
  attr(:on_sort, :any, default: nil)

  attr(:rest, :global, include: ["abbr", "colspan", "headers", "rowspan", "scope"])

  slot(:inner_block)

  def th(%{inner_block: []} = assigns) do
    ~H"""
    <th {@rest}></th>
    """
  end

  def th(%{on_sort: %JS{}, field: field} = assigns) when not is_nil(field) do
    ~H"""
    <th>
      <.dropdown
        id={"sort-options-#{@field}"}
        trigger_class={["table-label flex items-center", @field == @ordered_by && "active"]}
        class="w-min"
      >
        <%= render_slot(@inner_block) %>

        <.sort_icon selected_direction={@field == @ordered_by && @direction} />

        <:menu :let={%{close: close_menu}}>
          <.sort_item
            field={@field}
            ordered_by={@ordered_by}
            direction={@direction}
            on_sort={@on_sort}
            close_menu={close_menu}
            item_direction="asc"
            icon={:arrow_upward}
            text="Sort Ascending"
          />

          <.sort_item
            field={@field}
            ordered_by={@ordered_by}
            direction={@direction}
            on_sort={@on_sort}
            close_menu={close_menu}
            item_direction="desc"
            icon={:arrow_downward}
            text="Sort Descending"
          />
        </:menu>
      </.dropdown>
    </th>
    """
  end

  def th(assigns) do
    ~H"""
    <th {@rest}>
      <div class="table-label">
        <%= render_slot(@inner_block) %>
      </div>
    </th>
    """
  end

  attr(:rest, :global)

  slot(:inner_block)

  slot :empty do
    attr(:class, :any)
  end

  def tbody(assigns) do
    ~H"""
    <tbody {@rest}>
      <.tr :if={@empty != []} class="hidden">
        <.td colspan="100" class={["text-center", @empty[:class]]}>
          <%= render_slot(@empty) %>
        </.td>
      </.tr>

      <%= render_slot(@inner_block) %>
    </tbody>
    """
  end

  attr(:rest, :global, include: ["colspan", "headers", "rowspan"])

  slot(:inner_block)

  def td(assigns) do
    ~H"""
    <td {@rest}>
      <%= render_slot(@inner_block) %>
    </td>
    """
  end

  attr(:rest, :global)
  slot(:inner_block)

  def tfoot(assigns) do
    ~H"""
    <tfoot {@rest}>
      <%= render_slot(@inner_block) %>
    </tfoot>
    """
  end

  defp sort_item(assigns) do
    ~H"""
    <.dropdown_item
      class="flex items-center gap-1 text-body-xs font-normal text-nowrap px-2 py-3 cursor-pointer"
      selected={@field == @ordered_by && @item_direction == @direction}
      phx-click={
        (@on_sort && JS.exec(@on_sort, "data-close-menu")) ||
          @close_menu |> JS.dispatch("sort", detail: %{direction: @item_direction, order_by: @field})
      }
      phx-value-direction={@item_direction}
      phx-value-order_by={@field}
      data-close-menu={@close_menu}
    >
      <.icon icon={@icon} class="text-[16px]" />
      <%= @text %>
    </.dropdown_item>
    """
  end

  attr(:selected_direction, :any)

  defp sort_icon(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="16"
      height="16"
      viewBox="0 0 24 24"
      fill="none"
      class="text-neutral-700"
    >
      <path
        d="M16.7 8.475C16.9833 8.75833 17.05 9.08333 16.9 9.45C16.75 9.81667 16.4666 10 16.05 10L7.94998 10C7.53331 10 7.24998 9.81667 7.09998 9.45C6.94998 9.08333 7.01665 8.75833 7.29998 8.475L11.375 4.4C11.4583 4.3 11.554 4.22933 11.662 4.188C11.7706 4.146 11.8833 4.125 12 4.125C12.1166 4.125 12.229 4.146 12.337 4.188C12.4456 4.22933 12.5416 4.3 12.625 4.4L16.7 8.475"
        fill="currentColor"
        class={@selected_direction == "asc" && "text-neutral-900"}
      />
      <path
        d="M16.7 15.525L12.625 19.6C12.5416 19.7 12.4456 19.7707 12.337 19.812C12.229 19.854 12.1166 19.875 12 19.875C11.8833 19.875 11.7706 19.854 11.662 19.812C11.554 19.7707 11.4583 19.7 11.375 19.6L7.29998 15.525C7.01665 15.2417 6.94998 14.9167 7.09998 14.55C7.24998 14.1833 7.53331 14 7.94998 14L16.05 14C16.4666 14 16.75 14.1833 16.9 14.55C17.05 14.9167 16.9833 15.2417 16.7 15.525Z"
        fill="currentColor"
        class={@selected_direction == "desc" && "text-neutral-900"}
      />
    </svg>
    """
  end
end
