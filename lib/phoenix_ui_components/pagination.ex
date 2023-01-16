defmodule PhoenixUiComponents.Pagination do
  use PhoenixUiComponents, :component
  import Phoenix.HTML.Form
  import PhoenixUiComponents.Icon
  import PhoenixUiComponents.CustomLink
  import PhoenixUiComponents.Form, only: [field_input: 1, get_input_classes: 2]

  attr(:class, :string, default: nil)
  attr(:total_entries, :integer, default: nil)
  attr(:current_entries, :integer, default: nil)
  attr(:current_page, :integer, required: true)
  attr(:total_pages, :integer, required: true)
  attr(:form_attrs, :list, default: [])
  attr(:page_input_attrs, :list, default: [])
  attr(:select_attrs, :list, default: [])
  attr(:per_page, :integer, default: 15)
  attr(:per_page_options, :list, default: [15, 30, 45, 60])
  attr(:navigation_type, :string, values: ["href", "navigate", "patch"], default: "href")
  attr(:with_limit, :boolean, default: false)
  attr(:conn, :any, required: true)

  def pagination(assigns) do
    assigns =
      assigns
      |> assign(:current_page, get_page(assigns.current_page))

    ~H"""
    <div class={["bg-neutral-100 text-xs w-full", @class]}>
      <.form
        :let={f}
        for={@conn}
        method="get"
        {@form_attrs}
        x-data="pagination"
        x-on:submit.prevent="updateQueryParams"
      >
        <div class="grid grid-cols-4 gap-2">
          <div
            :if={@current_page && @per_page && @current_entries && @total_entries}
            class="flex items-center"
          >
            Showing
            <span class="font-bold px-1">
              <%= (@current_page - 1) * @per_page + @current_entries %>
            </span>
            out of
            <span class="font-bold px-1">
              <%= @total_entries %>
            </span>
            items.
          </div>

          <div class="col-start-2 col-end-4 flex items-center justify-center">
            <.custom_link
              class={[
                "flex items-center justify-center p-1",
                get_button_classes(@current_page == 1)
              ]}
              {get_navigation_attrs(@conn, 1 , @navigation_type)}
            >
              <.icon icon={:keyboard_double_arrow_left} class="text-[16px]" />
            </.custom_link>
            <.custom_link
              class={[
                "flex items-center justify-center p-1",
                get_button_classes(@current_page == 1)
              ]}
              {get_navigation_attrs(@conn, max(@current_page - 1, 1), @navigation_type)}
            >
              <.icon icon={:keyboard_arrow_left} class="text-[16px]" />
            </.custom_link>
            Page
            <.field_input
              required
              type="number"
              form={f}
              field={:page}
              value={@current_page}
              class={
                List.flatten([
                  get_input_classes("sm", "default"),
                  "!w-min min-w-max !px-1 text-center mx-2"
                ])
              }
              min={1}
              max={@total_pages}
              {@page_input_attrs}
            />
            <span>out of <span class="font-bold"><%= @total_pages %></span></span>
            <.custom_link
              class={[
                "flex items-center justify-center p-1",
                get_button_classes(@current_page == @total_pages)
              ]}
              {get_navigation_attrs(@conn, min(@current_page +  1, @total_pages), @navigation_type)}
            >
              <.icon icon={:keyboard_arrow_right} class="text-[16px]" />
            </.custom_link>
            <.custom_link
              class={[
                "flex items-center justify-center p-1",
                get_button_classes(@current_page == @total_pages)
              ]}
              {get_navigation_attrs(@conn, @total_pages , @navigation_type)}
            >
              <.icon icon={:keyboard_double_arrow_right} class="text-[16px]" />
            </.custom_link>
          </div>

          <div :if={@with_limit} class="flex items-center">
            Display
            <.field_input
              type="select"
              form={f}
              field={:per_page}
              options={@per_page_options}
              value={@per_page}
              class={List.flatten([get_input_classes("sm", "default"), "w-14 mx-2"])}
              {@select_attrs}
            /> items.
          </div>
        </div>
      </.form>
    </div>
    """
  end

  defp get_page(page) when is_binary(page), do: String.to_integer(page)
  defp get_page(page) when is_integer(page), do: page
  defp get_page(nil), do: 1

  defp get_button_classes(true), do: "text-neutral-500 pointer-events-none"
  defp get_button_classes(_), do: "text-neutral-900"

  defp get_navigation_attrs(conn, page, navigation_type) do
    query_string =
      conn.query_params
      |> Map.put("page", page)
      |> Plug.Conn.Query.encode()

    Map.new("#{navigation_type}": "#{conn.request_path}?#{query_string}")
  end
end
