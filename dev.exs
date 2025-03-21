Application.put_env(:example, Example.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: System.get_env("PORT", "4000")],
  server: true,
  live_view: [signing_salt: "aaaaaaaa"],
  secret_key_base: String.duplicate("a", 64),
  adapter: Bandit.PhoenixAdapter,
    watchers: [
    esbuild: {Esbuild, :install_and_run, [:storybook, ~w(--sourcemap=inline --watch)]},
    storybook_tailwind: {Tailwind, :install_and_run, [:storybook, ~w(--watch)]}
  ],
  pubsub_server: Example.PubSub,
  code_reloader: true,
  debug_errors: true,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"lib/.*/.*(ex)$",
      ~r"storybook/.*(exs)$"
    ]
  ]
)

defmodule Example.Gettext do
  use Gettext.Backend, otp_app: :example
end

Application.put_env(:phoenix_ui_components, :gettext_backend, Example.Gettext)

defmodule Example.ErrorView do
  def render(template, _), do: Phoenix.Controller.status_message_from_template(template)
end

defmodule Example.Storybook do
  use PhoenixStorybook,
    otp_app: :phoenix_ui_components_storybook,
    content_path: Path.expand("./storybook", __DIR__),
    # assets path are remote path, not local file-system paths
    css_path: "/assets/storybook.css",
    js_path: "/assets/storybook.js",
    sandbox_class: "phoenix-ui-components"
end


defmodule Example.Router do
  use Phoenix.Router

  import Phoenix.LiveView.Router
  import PhoenixStorybook.Router

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", Example do
    storybook_assets()
    pipe_through(:browser)

    live_storybook "/", backend_module: Example.Storybook
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
