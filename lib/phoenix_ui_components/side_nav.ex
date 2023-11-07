defmodule PhoenixUiComponents.SideNav do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Icon
  import PhoenixUiComponents.CustomLink
  import PhoenixUiComponents.Logo

  attr(:sections, :list,
    required: true,
    examples: [
      [
        %{label: "Link", icon: :info, href: "/"},
        %{label: "Live patch", icon: :info, patch: "/"},
        %{label: "Live redirect", icon: :info, navigate: "/"},
        %{
          label: "Nested",
          icon: :info,
          items: [
            %{label: "Label 1", href: "#"},
            %{label: "Label 2", navigate: "#"},
            %{label: "Label 3", patch: "#"}
          ]
        }
      ]
    ]
  )

  attr(:root_path, :string, default: nil)
  attr(:app_name, :string, default: nil)
  attr(:class, :string, default: nil)

  slot(:footer)

  def side_nav(assigns) do
    ~H"""
    <div class={["flex flex-col", @class]}>
      <div class="flex flex-col flex-1 min-h-0 bg-neutral-900 rounded-r-3xl">
        <.side_nav_header app_name={@app_name} root_path={@root_path} />
        <nav class="flex flex-col flex-1 px-4 overflow-y-auto">
          <.side_nav_section :for={{label, items} <- @sections} label={label} items={items} />
        </nav>

        <%= render_slot(@inner_block) %>

        <.side_nav_footer>
          <%= render_slot(@footer) %>
        </.side_nav_footer>
      </div>
    </div>
    """
  end

  attr(:root_path, :string, default: nil)
  attr(:app_name, :string, default: nil)

  def side_nav_header(assigns) do
    ~H"""
    <div class="flex items-center flex-shrink-0 px-4 py-3">
      <.custom_link
        :if={@root_path}
        href={@root_path}
        class="flex items-center justify-center w-10 h-10 mr-2 bg-white rounded-lg"
      >
        <.logo class="w-6 h-6" />
      </.custom_link>
      <span class="text-neutral-100">
        <%= @app_name %>
      </span>
    </div>
    """
  end

  slot(:inner_block)

  def side_nav_footer(assigns) do
    ~H"""
    <div class="flex items-center flex-shrink-0 px-4 mt-3 mb-6">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:label, :string, required: true)
  attr(:items, :list, required: true)

  def side_nav_section(assigns) do
    ~H"""
    <div class="mb-8 border-b-2 border-neutral-800 last:border-0">
      <p class="mb-2 text-sm font-bold uppercase text-neutral-600">
        <%= @label %>
      </p>
      <ul>
        <.side_nav_item :for={item <- @items} {item} />
      </ul>
    </div>
    """
  end

  attr(:label, :string, required: true)
  attr(:icon, :atom, required: true)
  attr(:items, :list, default: nil)
  attr(:rest, :global)

  def side_nav_item(%{items: items} = assigns) when not is_nil(items) do
    ~H"""
    <li class="mb-3 overflow-hidden text-sm text-neutral-500" x-data="dropdown">
      <.custom_link
        class={[
          "flex items-center py-2 pl-4 pr-2 rounded-lg bg-neutral-900 outline-offset-[-2px] w-full",
          active_link_classes()
        ]}
        x-bind="toggler"
        {@rest}
      >
        <.icon outlined icon={@icon} class="flex-shrink-0 mr-2" />
        <%= @label %>
        <.icon
          outlined
          icon={:keyboard_arrow_down}
          class="ml-auto transition-transform duration-300"
          x-bind="arrowIcon"
        />
      </.custom_link>

      <ul class="pt-2 overflow-hidden" x-bind="panel" x-cloak>
        <%= for item <-@items do %>
          <.side_nav_subitem {item} />
        <% end %>
      </ul>
    </li>
    """
  end

  def side_nav_item(assigns) do
    ~H"""
    <li class="mb-3 overflow-hidden text-sm text-neutral-500">
      <.custom_link
        class={[
          "flex items-center py-2 pl-4 pr-2 rounded-lg bg-neutral-900 outline-offset-[-2px] w-full",
          active_link_classes()
        ]}
        {@rest}
      >
        <.icon outlined icon={@icon} class="flex-shrink-0 mr-2" />
        <%= @label %>
      </.custom_link>
    </li>
    """
  end

  def side_nav_subitem(assigns) do
    ~H"""
    <li class="relative flex items-center pl-10 mb-2 text-sm last:mb-0 text-neutral-500">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 18 74"
        fill="none"
        class="absolute w-4 h-[72px] text-neutral-800 left-[26px] top-[-48px]"
      >
        <path
          d="M1 1V65C1 69.4183 4.58172 73 9 73H17"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
        />
      </svg>
      <.custom_link
        class={["py-2.5 px-2 w-full rounded-lg relative outline-offset-[-2px]", active_link_classes()]}
        {assigns}
      />
    </li>
    """
  end

  attr(:label, :string, default: "Dev tools")

  slot(:inner_block)

  def side_nav_dev_tools(assigns) do
    ~H"""
    <div class="px-4">
      <p class="mb-2 text-sm font-bold uppercase text-neutral-600">
        <%= @label %>
      </p>
      <ul>
        <%= render_slot(@inner_block) %>
      </ul>
    </div>
    """
  end

  attr(:primary, :string, required: true)
  attr(:secondary, :string)
  attr(:show_secondary, :boolean, default: true)
  attr(:icon, :atom, required: true)
  attr(:status, :string, values: ["default", "warning", "error"])
  attr(:errors_count, :integer, default: 0)
  attr(:warnings_count, :integer, default: 0)
  attr(:rest, :global, include: ["href", "navigate", "patch"])

  def dev_tools_item(assigns) do
    assigns =
      assigns
      |> assign_new(:status, &dev_tools_item_status/1)
      |> assign_new(:secondary, &secondary_text/1)

    ~H"""
    <li class="mb-2 overflow-hidden text-sm">
      <.custom_link
        class={[
          "flex items-center py-1.5 pl-4 pr-2 rounded-lg text-start bg-neutral-900 outline-offset-[-2px] w-full border min-h-[50px]",
          dev_tools_item_color(@status),
          "hover:bg-neutral-800 focus:bg-neutral-800"
        ]}
        {@rest}
      >
        <.icon icon={devtools_icon(@status, @icon)} class="flex-shrink-0 mr-2" />
        <div>
          <p>
            <%= @primary %>
          </p>

          <p :if={@show_secondary && @secondary} class="text-xs">
            <%= @secondary %>
          </p>
        </div>
        <.icon outlined icon={:chevron_right} class="flex-shrink-0 ml-auto" />
      </.custom_link>
    </li>
    """
  end

  defp dev_tools_item_status(%{errors_count: errors_count}) when errors_count > 0,
    do: "error"

  defp dev_tools_item_status(%{warnings_count: warnings_count}) when warnings_count > 0,
    do: "warning"

  defp dev_tools_item_status(_),
    do: "default"

  defp dev_tools_item_color("warning"),
    do: "text-warning-300 border-warning-300 outline-warning-300"

  defp dev_tools_item_color("error"), do: "text-error-400 border-error-400 outline-error-400"
  defp dev_tools_item_color(_), do: "text-neutral-500 border-neutral-500"

  defp devtools_icon("warning", _icon), do: :warning_amber
  defp devtools_icon("error", _icon), do: :error_outline
  defp devtools_icon(_status, icon), do: icon

  defp secondary_text(%{secondary: secondary}),
    do: secondary

  defp secondary_text(%{errors_count: errors_count}) when errors_count > 0,
    do: "#{errors_count} Errors"

  defp secondary_text(%{warnings_count: warnings_count}) when warnings_count > 0,
    do: "#{warnings_count} Warnings"

  defp secondary_text(_),
    do: "0 Errors"

  defp active_link_classes(),
    do: "hover:bg-neutral-800 focus:bg-neutral-800 focus:text-neutral-200 hover:text-neutral-200"
end
