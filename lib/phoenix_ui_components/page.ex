defmodule PhoenixUiComponents.Page do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Breadcrumbs

  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, default: [])

  def page(assigns) do
    ~H"""
    <div class={["page", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :string, default: nil)
  attr(:breadcrumbs, :list, default: nil)
  attr(:title, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, default: [])
  slot(:title_content)
  slot(:action, default: nil)

  def page_header(assigns) do
    ~H"""
    <div class={["page-header", @class]} {@rest}>
      <.breadcrumbs :if={@breadcrumbs} breadcrumbs={@breadcrumbs} class="mb-4" />

      <div :if={@title || @action != []} class="flex items-center justify-between space-x-3 mb-5">
        <div class="flex">
          <p class="text-h3">
            <%= @title %>
          </p>
          <%= render_slot(@title_content) %>
        </div>

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
    <div class={["page-content", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, default: [])
  slot(:action, default: nil)

  def page_footer(assigns) do
    ~H"""
    <div class={["page-footer", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
      <div :if={@action != []} class="flex items-center space-x-4 ml-auto">
        <%= render_slot(@action) %>
      </div>
    </div>
    """
  end
end
