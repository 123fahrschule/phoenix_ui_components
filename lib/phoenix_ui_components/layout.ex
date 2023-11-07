defmodule PhoenixUiComponents.Layout do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.SideNav
  import PhoenixUiComponents.TopNav
  import PhoenixUiComponents.Banner
  import PhoenixUiComponents.Button
  import PhoenixUiComponents.Logo

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
  slot(:dev_tools)

  def admin_layout(assigns) do
    ~H"""
    <div class="fixed left-[240px] right-0 top-[70px] z-50 space-y-4 px-14 pointer-events-none">
      <div
        :for={{flash_type, flash_message} <- @flash}
        id={"flash_#{flash_type}"}
        phx-hook="FlashMessage"
        data-type={flash_type}
        class="pointer-events-auto w-1/2 min-w-min mx-auto"
      >
        <.banner
          message={flash_message}
          type={flash_type}
          close_button_attributes={[
            "data-type": "close-btn"
          ]}
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
        <%= render_slot(@dev_tools) %>
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

  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, default: nil)

  def admin_login(assigns) do
    ~H"""
    <div class={["h-full bg-gradient-to-b from-primary-300 to-primary-500 pt-14", @class]} {@rest}>
      <.logo text_white class="w-[153px] mx-auto" />
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :string, default: nil)
  attr(:title, :string, default: "Hello 👋")
  attr(:description, :string, default: "Welcome to 123Fahrschule Admin Panel.")
  attr(:button_text, :string, default: "Login with microsoft")
  attr(:button_attrs, :list, default: [])
  attr(:rest, :global)

  def admin_login_form(assigns) do
    ~H"""
    <div class={["mt-[186px]", @class]} {@rest}>
      <div class="bg-neutral-100 rounded-3xl shadow-sm-3 p-10 max-w-[480px] mx-auto">
        <h2 class="mb-4"><%= @title %></h2>
        <p class="mb-6"><%= @description %></p>
        <.button primary label={@button_text} left_icon={:microsoft} class="w-full" {@button_attrs} />
      </div>
    </div>
    """
  end
end
