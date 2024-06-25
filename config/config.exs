import Config

if Mix.env() == :dev do
  esbuild = fn args ->
    [
      args: args ++ ~w(--external:tailwindcss/plugin --external:@tailwindcss/forms),
      cd: Path.expand("../assets", __DIR__),
      env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
    ]
  end

  config :esbuild,
    version: "0.14.41",
    module:
      esbuild.(
        ~w(./module.js --bundle --format=esm --sourcemap --outfile=../priv/static/module.mjs)
      ),
    main:
      esbuild.(
        ~w(./main.js --bundle --format=cjs --sourcemap --outfile=../priv/static/main.cjs.js)
      )
end
