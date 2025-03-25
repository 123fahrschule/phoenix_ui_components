defmodule PhoenixUiComponents.MixProject do
  use Mix.Project

  @version "2.0.0-rc.6"

  def project do
    [
      app: :phoenix_ui_components,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: []
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Productive. Reliable. Fast. A productive web framework that does not compromise speed and maintainability.
      {:phoenix, "~> 1.7"},
      # Rich, real-time user experiences with server-rendered HTML
      {:phoenix_live_view, "~> 1.0.5"},
      {:phoenix_html, "~> 4.2"},
      {:phoenix_html_helpers, "~> 1.0"},
      {:gettext, "~> 0.26.0"},
      {:scrivener_ecto, ">= 2.0.0 or >= 3.0.0"},

      # Dev dependencies
      {:esbuild, "~> 0.9", only: :dev},
      {:tailwind, "~> 0.2.0", only: :dev},
      {:jason, "~> 1.2", only: :dev},
      {:bandit, "~> 1.5", only: :dev},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_storybook, "~> 0.8.0", only: :dev}
    ]
  end

  defp aliases do
    [
      setup: [
        "deps.get",
        "assets.setup"
      ],
      "assets.setup": [
        "cmd npm install --prefix assets",
        "tailwind.install --if-missing",
        "esbuild.install --if-missing"
      ],
      "assets.build": [
        "esbuild module",
        "esbuild main",
        "cmd git add priv/static/{main,module}.*",
        "cmd git commit -m \"Build\\\ assets\""
      ],
      dev: "run dev.exs",
      release: [
        "cmd git tag #{@version}",
        "cmd git push",
        "cmd git push --tags"
      ]
    ]
  end
end
