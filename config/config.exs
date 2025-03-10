import Config

esbuild = fn args ->
  [
    args: args ++ ~w(--external:tailwindcss/plugin --external:@tailwindcss/forms),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]
end

config :esbuild,
  version: "0.14.41",
  dev:
    esbuild.(
      ~w(js/dev.js --bundle --target=es2017 --outdir=../priv/static/assets --loader:.woff2=file)
    ),
  module:
    esbuild.(
      ~w(./module.js --bundle --format=esm --sourcemap --outfile=../priv/static/module.mjs)
    ),
  main:
    esbuild.(~w(./main.js --bundle --format=cjs --sourcemap --outfile=../priv/static/main.cjs.js))
