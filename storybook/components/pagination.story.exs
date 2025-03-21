defmodule Storybook.Components.Pagination do
  use PhoenixStorybook.Story, :component

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

  def variations,
    do: [
      %Variation{
        id: :base,
        description: "Base pagiantion",
        attributes: %{
          paginated_entries: @page
        }
      },
      %Variation{
        id: :without_page_size_select,
        description: "Without page size select",
        attributes: %{
          paginated_entries: @page,
          page_size_options: []
        }
      }
    ]
end
