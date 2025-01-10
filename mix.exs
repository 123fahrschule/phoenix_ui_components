defmodule PhoenixUiComponents.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_ui_components,
      version: "1.4.2",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Productive. Reliable. Fast. A productive web framework that does not compromise speed and maintainability.
      {:phoenix, "~> 1.6.15 or ~> 1.7"},
      # Rich, real-time user experiences with server-rendered HTML
      {:phoenix_live_view, "~> 0.20.0"},
      {:phoenix_html, "~> 4.0"},
      {:phoenix_html_helpers, "~> 1.0"},

      # Dev dependencies
      {:esbuild, "~> 0.5", only: :dev}
    ]
  end

  defp aliases do
    [
      "assets.build": ["esbuild module", "esbuild main"],
      "assets.watch": "esbuild main --watch"
    ]
  end
end
