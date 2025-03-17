Application.put_env(:example, Example.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 5001],
  server: true,
  live_view: [signing_salt: "aaaaaaaa"],
  secret_key_base: String.duplicate("a", 64),
  adapter: Bandit.PhoenixAdapter,
    watchers: [
    esbuild: {Esbuild, :install_and_run, [:dev, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:dev, ~w(--watch)]}
  ],
  pubsub_server: Example.PubSub,
  code_reloader: true,
  debug_errors: true,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"lib/.*/.*(ex)$",
    ]
  ]
)

defmodule Example.ErrorView do
  def render(template, _), do: Phoenix.Controller.status_message_from_template(template)
end

defmodule Example.HomeLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    Hello
    """
  end
end

defmodule ExampleWeb.Layouts do
  use Phoenix.Component

  # Import convenience functions from controllers
  import Phoenix.Controller,
    only: [get_csrf_token: 0, view_module: 1, view_template: 1]

  def render("root.html", assigns) do
    ~H"""
    <!DOCTYPE html>
    <html lang="en" class="[scrollbar-gutter:stable]">
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="csrf-token" content={get_csrf_token()} />
        <.live_title default="App" suffix=" · Phoenix Framework">
          <%= assigns[:page_title] %>
        </.live_title>
        <script defer phx-track-static type="text/javascript" src={"/assets/dev.js"}>
        </script>
      </head>
      <body class="bg-white">
        <%= @inner_content %>
      </body>
    </html>
    """
  end

  def render("live.html", assigns) do
    ~H"""
    <%= @inner_content %>
    """
  end
end

defmodule Example.Router do
  use Phoenix.Router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug :put_root_layout, html: {ExampleWeb.Layouts, :root}
    plug :put_layout, html: {ExampleWeb.Layouts, :live}
  end

  scope "/", Example do
    pipe_through(:browser)

    live("/", HomeLive, :index)
  end
end

defmodule ExampleWeb do
  def static_paths, do: ~w(assets fonts images favicon.ico robots.txt)
end

defmodule Example.Endpoint do
  use Phoenix.Endpoint, otp_app: :example

   @session_options [
    store: :cookie,
    key: "_live_view_key",
    signing_salt: "/VEDsdfsffMnp5",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :phoenix_ui_components,
    gzip: false,
    only: ExampleWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Session, @session_options

  plug(Example.Router)
end

{:ok, _} = Supervisor.start_link([
  {Phoenix.PubSub, name: Example.PubSub},
  Example.Endpoint
], strategy: :one_for_one)
Process.sleep(:infinity)
