defmodule PhoenixUiComponents.Sidebar do
  use PhoenixUiComponents, :component

  import PhoenixUiComponents.Icon

  alias Phoenix.LiveView.JS

  attr :class, :any, default: nil
  attr :rest, :global

  slot :header
  slot :footer
  slot :inner_block

  def sidebar(assigns) do
    ~H"""
    <div
      id="sidebar"
      class={["relative z-50 hidden md:!block", @class]}
      data-show={
        JS.show()
        |> JS.show(
          to: "#sidebar-backdrop",
          transition: {"transition-opacity ease-linear duration-300", "opacity-0", "opacity-100"},
          time: 300
        )
        |> JS.show(
          to: "#sidebar-menu",
          transition:
            {"transition-transform ease-in-out delay-75 duration-300", "-translate-x-full",
             "translate-x-0"},
          time: 375
        )
        |> JS.focus_first()
      }
      data-hide={
        JS.hide(
          to: "#sidebar-menu",
          transition:
            {"transition-transform ease-in-out duration-300", "translate-x-0", "-translate-x-full"},
          time: 300
        )
        |> JS.hide(
          to: "#sidebar-backdrop",
          transition:
            {"transition-opacity ease-linear delay-75 duration-300", "opacity-100", "opacity-0"},
          time: 375
        )
        |> JS.hide(transition: "delay", time: 400)
      }
      phx-window-keydown={JS.exec("data-hide")}
      phx-key="escape"
      {@rest}
    >
      <div
        id="sidebar-backdrop"
        class="fixed inset-0 bg-neutral-800/50 hidden md:!hidden"
        phx-click={JS.exec("data-hide", to: "#sidebar")}
      />

      <div
        id="sidebar-menu"
        class="h-full fixed inset-y-0 left-0 w-[--sidebar-width] hidden md:!block md:transform-none md:relative"
      >
        <div class="bg-neutral-900 rounded-r-[16px] h-full relative py-3 pb-6 flex flex-col">
          <div class="h-12 pb-2 px-4 flex items-center justify-between gap-2 text-neutral-100">
            <%= render_slot(@header) %>

            <button
              phx-click={JS.exec("data-hide", to: "#sidebar")}
              class="flex rounded-full p-2 hover:bg-neutral-100/10 focus:bg-neutral-100/10 focus-visible:bg-neutral-100/10 focus-visible:outline-none md:hidden ml-auto"
            >
              <.icon icon={:close} class="text-[24px] text-neutral-100" />
            </button>
          </div>

          <div class="flex flex-col flex-1 min-h-0 overflow-y-auto pt-6 px-4">
            <%= render_slot(@inner_block) %>
          </div>

          <div :if={@footer != []} class="px-4">
            <%= render_slot(@footer) %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  attr :class, :any, default: nil
  attr :label, :string
  attr :rest, :global

  slot :inner_block

  def navigation_group(assigns) do
    ~H"""
    <div
      class={["pb-8 mb-8 last:pb-0 last:mb-0 border-b-2 border-neutral-800 last:border-0", @class]}
      {@rest}
    >
      <p class="text-h6 text-neutral-600 mb-2">
        <%= @label %>
      </p>
      <ul class="space-y-3">
        <%= render_slot(@inner_block) %>
      </ul>
    </div>
    """
  end

  defp item_class() do
    "flex items-center gap-2 py-2 pl-4 pr-2 rounded-[8px] bg-neutral-900 w-full text-start group"
  end

  defp active_item_class() do
    [
      "[&.active]:bg-neutral-800 [&.active]:text-neutral-200",
      "hover:bg-neutral-800 focus:bg-neutral-800 focus:text-neutral-200 hover:text-neutral-200",
      "border border-transparent",
      "focus-visible:outline-none focus-visible:border-neutral-100"
    ]
  end

  attr :class, :any, default: nil
  attr :label, :string
  attr :icon, :atom
  attr :active, :boolean, default: false
  attr :expanded, :boolean, default: false
  attr :rest, :global, include: ["navigate", "patch", "href"]

  slot :subitems
  slot :inner_block

  def navigation_item(%{subitems: []} = assigns) do
    ~H"""
    <li class={["text-body-sm text-neutral-500", @class]} {@rest}>
      <.link class={[@active && "active", item_class(), active_item_class()]} {@rest}>
        <.icon outlined icon={@icon} class="flex-shrink-0" />
        <span class="flex-grow">
          <%= @label %>
        </span>
        <%= render_slot(@inner_block) %>
      </.link>
    </li>
    """
  end

  def navigation_item(assigns) do
    ~H"""
    <li
      class={["text-body-sm text-neutral-500 group", @expanded && "expanded", @class]}
      phx-click={JS.toggle_class("expanded")}
      {@rest}
    >
      <button class={[@active && "active", item_class(), active_item_class()]} {@rest}>
        <.icon outlined icon={@icon} class="flex-shrink-0" />
        <span class="flex-grow">
          <%= @label %>
        </span>
        <%= render_slot(@inner_block) %>
        <.icon
          outlined
          icon={:keyboard_arrow_down}
          class="transition-transform duration-300 group-[.expanded]:rotate-180"
        />
      </button>
      <ul class="pt-2 overflow-hidden hidden group-[.expanded]:block">
        <%= render_slot(@subitems) %>
      </ul>
    </li>
    """
  end

  attr :class, :any, default: nil
  attr :label, :string
  attr :active, :boolean, default: false
  attr :rest, :global, include: ["navigate", "patch", "href"]

  slot :inner_block

  def navigation_subitem(assigns) do
    ~H"""
    <li class={[
      "relative flex items-center pl-10 mb-2 text-body-sm last:mb-0 text-neutral-500",
      @class
    ]}>
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
        class={[
          "py-2.5 px-2 flex gap-2 w-full rounded-lg relative outline-offset-[-2px]",
          @active && "active",
          active_item_class()
        ]}
        {@rest}
      >
        <span class="flex-grow">
          <%= @label %>
        </span>
        <%= render_slot(@inner_block) %>
      </.link>
    </li>
    """
  end

  attr :class, :any, default: nil
  attr :text, :string, default: nil
  attr :rest, :global

  slot :inner_block

  def navigation_item_badge(assigns) do
    ~H"""
    <span
      class={[
        "bg-neutral-800 text-body-sm text-neutral-200 rounded-[4px] size-6 flex items-center justify-center group-hover:bg-neutral-900 group-focus:bg-neutral-900 group-focus-visible:bg-neutral-900",
        @class
      ]}
      {@rest}
    >
      <%= @text || render_slot(@inner_block) %>
    </span>
    """
  end
end
