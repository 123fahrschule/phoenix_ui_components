defmodule PhoenixUiComponents.MixProject do
  use Mix.Project

  @version "2.0.0-rc.21"

  def project do
    [
      app: :phoenix_ui_components,
      version: @version,
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_paths: ["test", "lib"],
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: []
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Productive. Reliable. Fast. A productive web framework that does not compromise speed and maintainability.
      {:phoenix, "~> 1.7"},
      # Rich, real-time user experiences with server-rendered HTML
      {:phoenix_live_view, "~> 1.0.10"},
      {:phoenix_html, "~> 4.2"},
      {:gettext, "~> 0.26.0"},

      # Dev dependencies
      {:esbuild, "~> 0.9", only: :dev},
      {:tailwind, "~> 0.2.0", only: :dev},
      {:jason, "~> 1.2", only: :dev},
      {:bandit, "~> 1.6", only: :dev},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_storybook, "~> 0.8.2", only: :dev},
      {:scrivener_ecto, ">= 2.0.0 or >= 3.0.0", only: :dev}
    ]
  end

  defp aliases do
    [
      setup: [
        "deps.get",
        "assets.setup"
      ],
      "assets.setup": [
        "cmd npm install",
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
      check: [
        "format --check-formatted",
        "deps.unlock --check-unused",
        "compile --force --warnings-as-errors"
      ],
      release: [
        "check",
        "cmd git tag #{@version}",
        "cmd git push",
        "cmd git push --tags"
      ]
    ]
  end
end
