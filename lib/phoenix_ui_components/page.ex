defmodule PhoenixUiComponents.Page do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Breadcrumbs

  attr(:class, :string, default: nil)
  attr(:header_class, :string, default: nil)
  attr(:footer_class, :string, default: nil)
  attr(:title, :string, default: nil)
  attr(:breadcrumbs, :list, default: nil)
  attr(:rest, :global)

  slot(:inner_block, default: [])
  slot(:header, default: nil)
  slot(:actions, default: nil)
  slot(:footer, default: nil)

  def page(assigns) do
    ~H"""
    <div class={["h-full grid grid-rows-[auto_1fr_72px]", @class]} {@rest}>
      <div
        :if={not Enum.empty?(@header) || @title || not Enum.empty?(@actions)}
        class={[
          "bg-neutral-200 border-b border-neutral-300 px-14 pt-5",
          @header_class
        ]}
      >
        <.breadcrumbs :if={@breadcrumbs} breadcrumbs={@breadcrumbs} class="mb-4" />

        <div class="flex items-center justify-between space-x-3">
          <p :if={@title} class="text-2xl leading-[1.334] font-bold tracking-normal">
            <%= @title %>
          </p>

          <div :if={not Enum.empty?(@actions)} class="space-x-3 ml-auto">
            <%= render_slot(@actions) %>
          </div>
        </div>

        <%= render_slot(@header) %>
      </div>

      <div class={[
        "first:row-start-1 first:row-end-3 last:row-start-2 last:row-end-4 only:row-span-3 overflow-auto"
      ]}>
        <div class="px-14 pt-8 pb-6">
          <%= render_slot(@inner_block) %>
        </div>
      </div>

      <div :if={not Enum.empty?(@footer)} class={["border-t border-neutral-300 px-14", @footer_class]}>
        <%= render_slot(@footer) %>
      </div>
    </div>
    """
  end
end
