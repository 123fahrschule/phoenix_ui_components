defmodule Storybook.Components.Table do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.Table

  def layout, do: :one_column

  def function, do: &Table.table/1

  @data [
    %{id: 1, name: "John Doe", email: "john@example.com", active: true},
    %{id: 2, name: "Jane Smith", email: "jane@example.com", active: false},
    %{id: 3, name: "Bob Johnson", email: "bob@example.com", active: false}
  ]

  def variations do
    [
      %Variation{
        id: :basic_table,
        description: "Basic table with simple data",
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
        id: :table_with_actions,
        description: "Table with action buttons",
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
        id: :custom_column_rendering,
        description: "Table with custom column rendering",
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
        id: :empty_state,
        description: "Table with no data (TODO: Add empty state)",
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
