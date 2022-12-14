defmodule PhoenixUiComponents.Pagination do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Icon
  import PhoenixUiComponents.CustomLink
  import PhoenixUiComponents.Form, only: [field_input: 1, get_input_classes: 2]

  attr(:class, :string, default: nil)
  attr(:total_records, :integer, default: nil)
  attr(:current_records, :integer, default: nil)
  attr(:current_page, :integer, required: true)
  attr(:total_pages, :integer, required: true)
  attr(:form_attrs, :list, default: [])
  attr(:page_input_attrs, :list, default: [])
  attr(:select_attrs, :list, default: [])
  attr(:per_page, :integer, default: 15)
  attr(:per_page_options, :list, default: [15, 30, 45, 60])
  attr(:path, :string, default: "/:page")
  attr(:navigation_type, :string, values: ["href", "navigate", "patch"], default: "href")
  attr(:with_count, :boolean, default: false)
  attr(:with_limit, :boolean, default: false)

  def pagination(assigns) do
    ~H"""
    <div class={["bg-neutral-100 text-xs py-4 px-9", @class]}>
      <.form :let={f} for={:pagination} {@form_attrs}>
        <div class="grid grid-cols-3">
          <div
            :if={@with_count && @current_page && @per_page && @current_records && @total_records}
            class="flex items-center"
          >
            Showing
            <span class="font-bold px-1">
              <%= (@current_page - 1) * @per_page + @current_records %>
            </span>
            out of
            <span class="font-bold px-1">
              <%= @total_records %>
            </span>
            items.
          </div>

          <div class="col-col-start-2 grid-col-end-3 flex items-center justify-center">
            <.custom_link
              class={[
                "flex items-center justify-center p-1",
                get_button_classes(@current_page == 1)
              ]}
              {get_navigation_attrs(@path, 1 , @navigation_type)}
            >
              <.icon icon={:keyboard_double_arrow_left} class="text-[16px]" />
            </.custom_link>
            <.custom_link
              class={[
                "flex items-center justify-center p-1",
                get_button_classes(@current_page == 1)
              ]}
              {get_navigation_attrs(@path, max(@current_page - 1, 1), @navigation_type)}
            >
              <.icon icon={:keyboard_arrow_left} class="text-[16px]" />
            </.custom_link>
            Page
            <.field_input
              required
              type="number"
              form={f}
              field={:current_page}
              value={@current_page}
              class={
                List.flatten([get_input_classes("sm", "default"), "!w-10 !px-1 text-center mx-2"])
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
              {get_navigation_attrs(@path, min(@current_page +  1, @total_pages), @navigation_type)}
            >
              <.icon icon={:keyboard_arrow_right} class="text-[16px]" />
            </.custom_link>
            <.custom_link
              class={[
                "flex items-center justify-center p-1",
                get_button_classes(@current_page == @total_pages)
              ]}
              {get_navigation_attrs(@path, @total_pages , @navigation_type)}
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

  defp get_button_classes(true), do: "text-neutral-500 pointer-events-none"
  defp get_button_classes(_), do: "text-neutral-900"

  defp get_path(path, page) do
    String.replace(path, "page_number", Integer.to_string(page))
  end

  defp get_navigation_attrs(path, page, navigation_type) do
    Map.new("#{navigation_type}": get_path(path, page))
  end
end
