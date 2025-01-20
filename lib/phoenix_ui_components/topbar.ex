defmodule PhoenixUiComponents.Topbar do
  use PhoenixUiComponents, :component

  import PhoenixUiComponents.Icon

  alias Phoenix.LiveView.JS

  attr(:class, :any, default: nil)
  attr(:rest, :global)

  slot(:inner_block)

  def topbar(assigns) do
    ~H"""
    <div
      id="topbar"
      class={[
        "px-4 py-3 flex items-center gap-2 bg-neutral-100 border-b border-neutral-300",
        @class
      ]}
      {@rest}
    >
      <button
        phx-click={JS.exec("data-show", to: "#sidebar")}
        class="flex rounded-full p-2 md:hidden hover:bg-neutral-200"
      >
        <.icon icon={:menu} class="text-[24px]" />
      </button>

      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
