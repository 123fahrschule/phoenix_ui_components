# PhoenixUiComponents

## Installation

The package can be installed by adding `phoenix_ui_components` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phoenix_ui_components, github: "123fahrschule/phoenix_ui_components", tag: "1.0.2"}
  ]
end
```

Configure [Tailwind](https://github.com/phoenixframework/tailwind) and [Esbuild](https://github.com/phoenixframework/esbuild)

Install required node modules inside `assets`

```term
npm install alpinejs@3.10.3 material-icons@1.11.11 --prefix ./assets --save-exact
```

Add preset and plugin to the tailwind config file and add path to package in content section

```js
// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin");

module.exports = {
  presets: [require("../deps/phoenix_ui_components").preset],
  content: [
    // ...
    "../deps/phoenix_ui_components/**/*.*ex",
    "../deps/phoenix_ui_components/priv/static/**/*.*js",
  ],
  plugins: [
    // ...
    plugin(require("../deps/phoenix_ui_components").plugin),
  ],
};
```

Import icons, styles and add required components for Alpine in main `*.js` file

```js
import "material-icons/iconfont/filled.css";
import "material-icons/iconfont/outlined.css";

import "phoenix_ui_components/priv/static/style.css";
import "phoenix_ui_components/priv/static/fonts.css";

import Alpine from "alpinejs";

import { dropdown, multiselect } from "phoenix_ui_components";

window.Alpine = Alpine;

Alpine.data("dropdown", dropdown);
Alpine.data("multiselect", multiselect);

Alpine.start();
```

Set required options for esbuild in `config/config.exs` (target and loaders for fonts)

```elixir
config :esbuild,
  [name]: [
    args:
      ~w(js/index.js --bundle --target=es2017 --outdir=../priv/static/assets --loader:.woff=file --loader:.woff2=file),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

```

use PhoenixUiComponents in layout view and change root layout

```heex
<.root_layout>
  <:head>
    <%= csrf_meta_tag() %>
    <%= live_title_tag("App name") %>
    ...
  </:head>
  <%= @inner_content %>
</.root_layout>

```

## Local development

Change dependency from `github` to `local` in `mix.exs`

```diff
-{:phoenix_ui_components, github: "123fahrschule/phoenix_ui_components" }
+{:phoenix_ui_components, path: "local_path/to/phoenix_ui_components" }
```

Add absolute path to package in `mix.exs` to `elixirc_paths` section.

Update esbuild config

New `NODE_PATH` should point to the directory with the package

```diff
config :esbuild,
  [name]: [
    args:
      ~w(js/index.js --bundle --target=es2017 --outdir=../priv/static/assets --loader:.woff=file --loader:.woff2=file),
    cd: Path.expand("../assets", __DIR__),
-    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
+    env: %{
+      "NODE_PATH" =>
+        Enum.join([Path.expand("../deps", __DIR__), Path.expand("local_path/to/directory_with_phoenix_ui_components", __DIR__)], ":")
+    }
  ]
```

Update tailwind config

```diff
module.exports = {
-  presets: [require("../deps/phoenix_ui_components").preset],
+  presets: [require("local_path/to/phoenix_ui_components").preset],
  content: [
-    "../deps/phoenix_ui_components/**/*.*ex",
+    "local_path/to/phoenix_ui_components/**/*.*ex",
-    "../deps/phoenix_ui_components/priv/static/**/*.*js",
+    "local_path/to/phoenix_ui_components/priv/static/**/*.*js",
  ],
  plugins: [
    // ...
-    plugin(require("../deps/phoenix_ui_components").plugin),
+    plugin(require("local_path/to/phoenix_ui_components").plugin),
  ],
};
```

If you want to change assets, then inside your local package run

```term
mix assets.watch
```

If you wish to commit new assets, then bundle them and add to commit changes inside `priv/static/assets`

```term
mix assets.build
```
