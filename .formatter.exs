# Used by "mix format"
[
  plugins: [Phoenix.LiveView.HTMLFormatter],
  migrate_eex_to_curly_interpolation: false,
  inputs: [
    "{mix,.formatter}.exs",
    "{config,lib,test}/**/*.{heex,ex,exs}",
    "storybook/**/*.exs"
  ]
]
