defmodule PhoenixUiComponents.Pagination do
  use Phoenix.LiveComponent
  use Gettext, backend: PhoenixUiComponents.Gettext

  import Phoenix.HTML
  import PhoenixUiComponents.Icon

  alias Phoenix.LiveView.JS

  @doc """
  Renders pagination component.
  It handles updating of `page` and `page_size` query params via hook

  A `Scrivener.Page` may be passed as argument, which is used to retrieve current_page,
  total_pages, current_entries_count, total_entries, page_size.
  Otherwise all attributes may be passed explicitly.

  ## Examples

      <.pagination paginated_entries={Repo.paginate(SomeModel, page: 1, page_size: 10)} />

      <.pagination
        current_page={10}
        total_pages={50}
        current_entries_count={15}
        total_entries={500}
        page_size={15}
        page_size_options={[15, 30, 45]}
      />
  """

  attr :id, :string, default: "pagination"
  attr :class, :any, default: nil
  attr :paginated_entries, Page, default: nil
  attr :pagination, :map, default: nil
  attr :current_page, :integer, default: 1
  attr :total_pages, :integer
  attr :current_entries_count, :integer
  attr :total_entries, :integer
  attr :page_size, :integer, default: 1
  attr :page_size_options, :list, default: Enum.to_list(10..50//10)
  attr :change_event, :string, default: nil
  attr :target, :any, default: nil

  def pagination(%{pagination: pagination} = assigns) when is_map(pagination) do
    assigns
    |> assign(assigns.pagination)
    |> assign(pagination: nil)
    |> pagination()
  end

  def pagination(%{paginated_entries: paginated_entries} = assigns)
      when is_struct(paginated_entries, Scrivener.Page) do
    assigns
    |> assign(to_pagination_attr(assigns.paginated_entries))
    |> assign(paginated_entries: nil)
    |> pagination()
  end

  def pagination(assigns) do
    ~H"""
    <div
      id={@id}
      phx-hook="Pagination"
      class={["bg-neutral-100 w-full text-body-xs text-neutral-900", @class]}
      data-change-event={@change_event}
      data-target={@target}
    >
      <form>
        <div class="grid grid-cols-4 gap-1">
          <div class="flex items-center gap-1">
            {pgettext(
              "pagination, showing entries info",
              "Showing %{number_of_entries} out of %{total_entries} items",
              number_of_entries: @current_entries_count |> bold(),
              total_entries: @total_entries |> bold()
            )
            |> raw()}
          </div>

          <div class="col-span-2 flex items-center justify-center gap-2">
            <.pagination_button
              phx-click={
                JS.dispatch("update-pagination-page",
                  detail: %{page: 1, page_size: @page_size}
                )
              }
              icon={:keyboard_double_arrow_left}
              disabled={@current_page == 1}
            />
            <.pagination_button
              phx-click={
                JS.dispatch("update-pagination-page",
                  detail: %{page: @current_page - 1, page_size: @page_size}
                )
              }
              icon={:keyboard_arrow_left}
              disabled={@current_page == 1}
            />

            {pgettext(
              "pagination, text for showing which page number is being displayed",
              "Page %{page_input} out of %{total_pages}",
              page_input:
                page_input(assigns)
                |> Phoenix.HTML.Safe.to_iodata()
                |> to_string(),
              total_pages: @total_pages |> bold()
            )
            |> raw()}

            <.pagination_button
              phx-click={
                JS.dispatch("update-pagination-page",
                  detail: %{page: @current_page + 1, page_size: @page_size}
                )
              }
              icon={:keyboard_arrow_right}
              disabled={@current_page == @total_pages}
            />
            <.pagination_button
              phx-click={
                JS.dispatch("update-pagination-page",
                  detail: %{page: @total_pages, page_size: @page_size}
                )
              }
              icon={:keyboard_double_arrow_right}
              disabled={@current_page == @total_pages}
            />
          </div>

          <div class="flex items-center gap-2 justify-end">
            <%= if @page_size_options != []  do %>
              {pgettext(
                "pagination, text for choosing how many items are shown per page",
                "Display %{page_size_select} items",
                page_size_select:
                  page_size_select(assigns)
                  |> Phoenix.HTML.Safe.to_iodata()
                  |> to_string()
              )
              |> raw()}
            <% end %>
          </div>
        </div>
      </form>
    </div>
    """
  end

  attr :icon, :atom
  attr :rest, :global, include: ["disabled"]

  defp pagination_button(assigns) do
    ~H"""
    <button type="button" class="text-neutral-900 disabled:text-neutral-500 flex" {@rest}>
      <.icon icon={@icon} class="text-[16px]" />
    </button>
    """
  end

  defp page_input(assigns) do
    ~H"""
    <input
      type="text"
      name="page"
      value={Phoenix.HTML.Form.normalize_value("text", @current_page)}
      class={[input_class(), "text-center w-[75px]"]}
      data-max-value={@total_pages}
    />
    """
  end

  defp page_size_select(assigns) do
    ~H"""
    <select name="page-size" class={[input_class(), "py-2 pl-4"]}>
      {Phoenix.HTML.Form.options_for_select(@page_size_options, @page_size)}
    </select>
    """
  end

  defp input_class(),
    do:
      "rounded-full shadow-input focus:shadow-input-focus focus:ring-0 border-neutral-300 focus:border-primary-300 bg-neutral-200/50 text-body-xs"

  defp bold(str), do: "<b>#{str |> html_escape() |> safe_to_string()}</b>"

  def to_pagination_attr(paginated_entries) when is_map(paginated_entries) do
    %{
      current_page: paginated_entries.page_number,
      total_pages: paginated_entries.total_pages,
      current_entries_count: Enum.count(paginated_entries.entries),
      total_entries: paginated_entries.total_entries,
      page_size: paginated_entries.page_size
    }
  end
end
