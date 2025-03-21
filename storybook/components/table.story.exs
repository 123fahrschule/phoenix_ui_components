defmodule Storybook.Components.Table do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.Table

  def layout, do: :one_column

  def imports,
    do: [
      {Button, button: 1},
      {Table, thead: 1, th: 1, tbody: 1, tr: 1, td: 1},
      {__MODULE__, data: 0}
    ]

  def function, do: &Table.table/1

  @data [
    %{id: 1, name: "John Doe", email: "john@example.com", active: true},
    %{id: 2, name: "Jane Smith", email: "jane@example.com", active: false},
    %{id: 3, name: "Bob Johnson", email: "bob@example.com", active: false}
  ]

  def variations do
    [
      %Variation{
        id: :base,
        description: "Basic table with simple data",
        attributes: %{},
        slots: [
          """
          <.thead>
            <:th label="ID" />
            <:th label="Name" />
            <:th label="Email" />
          </.thead>

          <.tbody>
            <.tr :for={entry <- data()}>
              <.td><%= entry.id %></.td>
              <.td><%= entry.name %></.td>
              <.td><%= entry.email %></.td>
            </.tr>
          </.tbody>
          """
        ]
      },
      %Variation{
        id: :table_with_actions,
        description: "Table with action buttons",
        attributes: %{},
        slots: [
          """
          <.thead>
            <:th label="ID" />
            <:th label="Name" />
            <:th label="Email" />
            <:th />
          </.thead>

          <.tbody>
            <.tr :for={entry <- data()}>
              <.td><%= entry.id %></.td>
              <.td><%= entry.name %></.td>
              <.td><%= entry.email %></.td>
              <.td>
                <div class="flex items-center gap-1">
                  <.link href="#">Edit</.link>
                  <.button tertiary size="sm" label="Delete" />
                </div>
              </.td>
            </.tr>
          </.tbody>
          """
        ]
      },
      %Variation{
        id: :empty,
        description: "Table with no data",
        attributes: %{},
        slots: [
          """
          <.thead>
            <:th label="ID" />
            <:th label="Name" />
            <:th label="Email" />
          </.thead>

          <.tbody>
            <.tr :for={entry <- []}>
              <.td><%= entry.id %></.td>
              <.td><%= entry.name %></.td>
              <.td><%= entry.email %></.td>
            </.tr>

            <:empty>
              <div class="flex items-center justify-center h-[100px] text-h6">
                EMPTY
              </div>
             </:empty>
          </.tbody>
          """
        ]
      },
      %Variation{
        id: :styled_cells,
        description: "Custom styling",
        attributes: %{},
        slots: [
          """
          <.thead>
            <:th label="ID" />
            <:th label="Name" />
            <:th label="Email" />
          </.thead>

          <.tbody>
            <.tr :for={entry <- data()} >
              <.td class="bg-success-100 text-success-400"><%= entry.id %></.td>
              <.td class="w-full"><%= entry.name %></.td>
              <.td class="bg-info-100 text-info-500"><%= entry.email %></.td>
            </.tr>
          </.tbody>
          """
        ]
      },
      %Variation{
        id: :old_basic_table,
        description: "Basic table with simple data (old)",
        attributes: %{
          rows: @data
        },
        slots: [
          """
          <:col label="ID" field={:id} />
          """,
          """
          <:col label="Name" field={:name} />
          """,
          """
          <:col label="Email" field={:email} />
          """
        ]
      },
      %Variation{
        id: :old_table_with_actions,
        description: "Table with action buttons (old)",
        attributes: %{
          rows: @data
        },
        slots: [
          """
          <:col label="ID" field={:id} />
          """,
          """
          <:col label="Name" field={:name} />
          """,
          """
          <:col label="Email" field={:email} />
          """,
          """
          <:action :let={_entry}>
            <.link href="#">Edit</.link>
          </:action>
          """,
          """
          <:action :let={_entry}>
            <button>Delete</button>
          </:action>
          """
        ]
      },
      %Variation{
        id: :old_custom_column_rendering,
        description: "Table with custom column rendering (old)",
        attributes: %{
          rows: @data
        },
        slots: [
          """
          <:col label="ID" :let={entry} >
            <.link navigate="#" class="underline">
              <%= entry.id %>
            </.link>
          </:col>
          """,
          """
          <:col label="Name" field={:name} />
          """,
          """
          <:col label="Email" field={:email} />
          """,
          """
          <:col label="Status" :let={entry}>
            <%= if entry.active do %>
              <span class="text-success-400">
                Active
              </span>
            <% else %>
              <span class="text-error-400">
                Inactive
              </span>
            <% end %>
          </:col>
          """
        ]
      },
      %Variation{
        id: :old_empty_state,
        description: "Table with no data (TODO: Add empty state)(old)",
        attributes: %{
          rows: [],
          col: [
            %{label: "ID", field: :id},
            %{label: "Name", field: :name},
            %{label: "Email", field: :email}
          ]
        }
      }
    ]
  end
end
