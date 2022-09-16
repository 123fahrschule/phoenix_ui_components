defmodule PhoenixUiComponents.SideNav do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Link
  import PhoenixUiComponents.Logo

  # attr :sections, :list, required: true, docs: "["Section name": [%{label: "Item label", icon: :info, ...link attributes}]]
  def side_nav(assigns) do
    ~H"""
    <div class="fixed inset-y-0 left-0 flex flex-col w-64">
      <div class="flex flex-col flex-1 min-h-0 bg-neutral-900 rounded-r-3xl">
        <.side_nav_header />
        <nav class="flex flex-col flex-1 px-4 overflow-y-auto">
          <%= for {label, items} <- @sections do %>
            <.side_nav_section label={label} items={items} />
          <% end %>
        </nav>
        <.side_nav_footer />
      </div>
    </div>
    """
  end

  def side_nav_header(assigns) do
    ~H"""
    <div class="flex items-center flex-shrink-0 px-4 py-3">
      <.link href="#" class="flex items-center justify-center w-10 h-10 mr-2 bg-white rounded-lg">
        <.logo class="w-6 h-6" />
      </.link>
    </div>
    """
  end

  def side_nav_footer(assigns) do
    ~H"""
    <div class="flex items-center flex-shrink-0 px-4 mt-3 mb-6"></div>
    """
  end

  # attr :label, :string,required: true
  # attr :items, :list, required: true
  def side_nav_section(assigns) do
    ~H"""
    <div class="mb-8 border-b-2 border-neutral-800 last:border-0">
      <p class="mb-2 text-sm font-bold uppercase text-neutral-600"><%= @label %></p>
      <ul>
        <%= for item <-@items do %>
          <.side_nav_item {item} />
        <% end %>
      </ul>
    </div>
    """
  end

  # attr :label, :string, required: true
  # attr :icon, :atom, required: true
  # attr :items, :list, default: nil
  # attr :rest, :global
  def side_nav_item(%{items: _} = assigns) do
    assigns =
      assigns
      |> assign_attr(:items)
      |> assign_rest([:label, :icon, :items])

    ~H"""
    <li class="mb-3 overflow-hidden text-sm text-neutral-500" x-data="dropdown">
      <.link
        class={
          [
            "flex items-center py-2 pl-4 pr-2 rounded-lg bg-neutral-900 outline-offset-[-2px] w-full",
            active_link_classes()
          ]
        }
        x-bind="toggler"
        {@rest}
      >
        <MaterialIcons.icon outlined icon={@icon} class="flex-shrink-0 mr-2" />
        <%= @label %>
        <MaterialIcons.icon
          outlined
          icon={:keyboard_arrow_down}
          class="ml-auto transition-transform duration-300"
          x-bind="arrowIcon"
        />
      </.link>

      <ul class="pt-2 overflow-hidden" x-bind="panel" x-cloak>
        <%= for item <-@items do %>
          <.side_nav_subitem {item} />
        <% end %>
      </ul>
    </li>
    """
  end

  # attr :label, :string, required: true
  # attr :icon, :atom, required: true
  # attr :rest, :global
  def side_nav_item(assigns) do
    assigns =
      assigns
      |> assign_rest([:label, :icon])

    ~H"""
    <li class="mb-3 overflow-hidden text-sm text-neutral-500">
      <.link
        class={
          [
            "flex items-center py-2 pl-4 pr-2 rounded-lg bg-neutral-900 outline-offset-[-2px] w-full",
            active_link_classes()
          ]
        }
        {@rest}
      >
        <MaterialIcons.icon outlined icon={@icon} class="flex-shrink-0 mr-2" />
        <%= @label %>
      </.link>
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
      <.link
        class={
          ["py-2.5 px-2 w-full rounded-lg relative outline-offset-[-2px]", active_link_classes()]
        }
        {assigns}
      />
    </li>
    """
  end

  defp active_link_classes(),
    do: "hover:bg-neutral-800 focus:bg-neutral-800 focus:text-neutral-200 hover:text-neutral-200"
end
