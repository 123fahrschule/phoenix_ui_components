import Config

if config_env() == :dev do
  esbuild = fn args ->
    [
      args: args ++ ~w(--external:tailwindcss/plugin --external:@tailwindcss/forms),
      cd: Path.expand("../assets", __DIR__),
      env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
    ]
  end

  config :esbuild,
    version: "0.25.1",
    storybook:
      esbuild.(
        ~w(js/storybook.js js/fonts.js --bundle --target=es2017 --outdir=../priv/static/assets --loader:.woff2=file)
      ),
    module:
      esbuild.(
        ~w(./module.js --bundle --format=esm --sourcemap --outfile=../priv/static/module.mjs)
      ),
    main:
      esbuild.(
        ~w(./main.js --bundle --format=cjs --sourcemap --outfile=../priv/static/main.cjs.js)
      )

  # Configure tailwind (the version is required)
  config :tailwind,
    version: "3.4.17",
    storybook: [
      args: ~w(
      --config=tailwind.storybook.config.js
      --input=css/storybook.css
      --output=../priv/static/assets/storybook.css
    ),
      cd: Path.expand("../assets", __DIR__)
    ]
end
