defmodule Storybook.Components.Pagination do
  use PhoenixStorybook.Story, :component

  import PhoenixUiComponents.Pagination, only: [to_pagination_attr: 1]

  alias PhoenixUiComponents.Pagination

  alias Scrivener.Page

  def layout, do: :one_column

  def function, do: &Pagination.pagination/1

  @page %Page{
    page_number: 1,
    page_size: 10,
    total_entries: 100,
    total_pages: 10,
    entries: []
  }

  @pagination to_pagination_attr(@page)

  def variations,
    do: [
      %Variation{
        id: :base,
        description: "Base pagiantion",
        attributes: %{
          pagination: @pagination
        }
      },
      %Variation{
        id: :without_page_size_select,
        description: "Without page size select",
        attributes: %{
          pagination: @pagination,
          page_size_options: []
        }
      },
      %Variation{
        id: :scrievener_page,
        description: "Scrivener.Page",
        attributes: %{
          paginated_entries: @page
        }
      },
      %Variation{
        id: :all_attrs,
        description: "All attributes are passed directly",
        attributes: %{
          current_page: 1,
          total_pages: 10,
          current_entries_count: 10,
          total_entries: 100,
          page_size: 10
        }
      }
    ]
end
