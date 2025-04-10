defmodule PhoenixUiComponents.Flyout do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Button
  import PhoenixUiComponents.Icon
  import PhoenixUiComponents.CustomLink

  attr :class, :string, default: nil
  attr :title, :string, default: nil
  attr :description, :string, default: nil
  attr :close_button_attrs, :list, default: nil
  attr :new_tab_url, :string, default: nil

  slot :inner_block
  slot :header
  slot :footer

  # TODO: Fix shadow
  def flyout(assigns) do
    ~H"""
    <div class={["bg-neutral-100 shadow-inner relative z-10", @class]}>
      <.flyout_header class={if @close_button_attrs, do: "pr-14"}>
        <%= if @title || @description do %>
          <div class="flex justify-between">
            <p class="text-2xl leading-[1.334] font-bold tracking-normal mb-2">
              <%= @title %>
            </p>
            <p>
              <.custom_link
                href={@new_tab_url}
                target="_blank"
                class="flex items-center justify-center p-2 text-xs uppercase text-neutral-700 font-bold"
              >
                <.icon icon={:arrow_outward} class="text-neutral-700 text-[16px] mr-2" />
                Open in new tab
              </.custom_link>
            </p>
          </div>
          <p class="text-neutral-600">
            <%= @description %>
          </p>
        <% else %>
          <%= render_slot(@header) %>
        <% end %>
        <.button
          :if={@close_button_attrs}
          color="white"
          size="sm"
          icon={:close}
          class="text-neutral-700 absolute top-8 right-6"
        />
      </.flyout_header>

      <.flyout_body>
        <%= render_slot(@inner_block) %>
      </.flyout_body>

      <.flyout_footer :if={@footer != []}>
        <%= render_slot(@footer) %>
      </.flyout_footer>
    </div>
    """
  end

  attr :class, :string, default: nil

  slot :inner_block

  def flyout_header(assigns) do
    ~H"""
    <div class={["p-8", @class]}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  slot :inner_block

  def flyout_body(assigns) do
    ~H"""
    <div class="px-8">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  slot :inner_block

  def flyout_footer(assigns) do
    ~H"""
    <div class="p-8">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
