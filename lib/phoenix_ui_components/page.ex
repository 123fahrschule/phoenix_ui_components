defmodule PhoenixUiComponents.Page do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Breadcrumbs

  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, default: [])

  def page(assigns) do
    ~H"""
    <div class={["h-full grid grid-rows-[auto_1fr_72px]", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :string, default: nil)
  attr(:breadcrumbs, :list, default: nil)
  attr(:title, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, default: [])
  slot(:action, default: nil)

  def page_header(assigns) do
    ~H"""
    <div
      class={[
        "bg-neutral-200 border-b border-neutral-300 px-14 pt-5",
        @class
      ]}
      {@rest}
    >
      <.breadcrumbs :if={@breadcrumbs} breadcrumbs={@breadcrumbs} class="mb-4" />

      <div :if={@title || @action != []} class="flex items-center justify-between space-x-3 mb-5">
        <p class="text-2xl leading-[1.334] font-bold tracking-normal">
          <%= @title %>
        </p>

        <div class="space-x-3 ml-auto">
          <%= render_slot(@action) %>
        </div>
      </div>

      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, default: [])

  def page_content(assigns) do
    ~H"""
    <div
      class={[
        "first:row-start-1 first:row-end-3 last:row-start-2 last:row-end-4 only:row-span-3 overflow-auto",
        @class
      ]}
      {@rest}
    >
      <div class="px-14 pt-8 pb-6">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, default: [])
  slot(:action, default: nil)

  def page_footer(assigns) do
    ~H"""
    <div class={["flex items-center border-t border-neutral-300 px-14 py-4", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
      <div :if={@action != []} class="flex items-center space-x-4 ml-auto">
        <%= render_slot(@action) %>
      </div>
    </div>
    """
  end
end
