defmodule PhoenixUiComponents.Layout do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.SideNav
  import PhoenixUiComponents.TopNav

  slot(:head, default: [])
  slot(:inner_block, required: true)

  def root_layout(assigns) do
    ~H"""
    <!DOCTYPE html>
    <html lang="de" class="h-full">
      <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <%= render_slot(@head) %>
        <.critical_styles />
      </head>
      <body class="h-full bg-white text-neutral-900">
        <%= render_slot(@inner_block) %>
      </body>
    </html>
    """
  end

  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, required: true)

  def page_content(assigns) do
    ~H"""
    <div class={["ml-64", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  def critical_styles(assigns) do
    ~H"""
    <style>
      [x-cloak] { display: none !important; }
      .material-icons, .material-icons-outlined {
        min-width: 1em;
        max-width: 1em;
        overflow: hidden;
      }
    </style>
    """
  end

  attr(:app_name, :string, default: nil)
  attr(:root_path, :string, default: nil)
  attr(:nav_sections, :list, required: true)

  slot(:inner_block, required: true)

  def admin_layout(assigns) do
    ~H"""
    <div class="grid grid-cols-[240px_auto] grid-rows-[64px_auto] h-full bg-neutral-100">
      <PhoenixUiComponents.SideNav.side_nav
        app_name={@app_name}
        root_path={@root_path}
        sections={@nav_sections}
        class="row-span-2"
      >
      </PhoenixUiComponents.SideNav.side_nav>
      <PhoenixUiComponents.TopNav.top_nav_container />
      <main class="overflow-auto">
        <%= render_slot(@inner_block) %>
      </main>
    </div>
    """
  end
end
