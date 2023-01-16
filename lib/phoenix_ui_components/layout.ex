defmodule PhoenixUiComponents.Layout do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.SideNav
  import PhoenixUiComponents.TopNav
  import PhoenixUiComponents.Banner

  attr(:lang, :string, default: "de")

  slot(:head, default: [])
  slot(:inner_block, required: true)

  def root_layout(assigns) do
    ~H"""
    <!DOCTYPE html>
    <html lang={@lang} class="h-full">
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
  attr(:flash, :map, default: %{})

  slot(:inner_block, required: true)
  slot(:top_nav_content, default: nil)
  slot(:side_nav_footer, default: nil)

  def admin_layout(assigns) do
    ~H"""
    <div class="fixed left-[240px] right-0 top-[70px] z-50 space-y-4 px-14 pointer-events-none">
      <div
        :for={{flash_type, flash_message} <- @flash}
        x-data={"flashMessage(\"#{flash_type}\")"}
        x-show="show"
        class="pointer-events-auto w-1/2 min-w-min mx-auto"
      >
        <.banner
          message={flash_message}
          type={flash_type}
          close_button_attributes={["@click": "close"]}
          class="shadow-sm-3"
        />
      </div>
    </div>

    <div class="grid grid-cols-[240px_auto] grid-rows-[64px_auto] h-full bg-neutral-100">
      <.side_nav
        app_name={@app_name}
        root_path={@root_path}
        sections={@nav_sections}
        class="row-span-2"
      >
        <:footer>
          <%= render_slot(@side_nav_footer) %>
        </:footer>
      </.side_nav>
      <.top_nav_container>
        <%= render_slot(@top_nav_content) %>
      </.top_nav_container>
      <main class="overflow-auto">
        <%= render_slot(@inner_block) %>
      </main>
    </div>
    """
  end
end
