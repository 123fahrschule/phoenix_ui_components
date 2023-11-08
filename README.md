# PhoenixUiComponents

## Installation

The package can be installed by adding `phoenix_ui_components` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phoenix_ui_components, github: "123fahrschule/phoenix_ui_components", tag: "1.2.2"}
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

Import icons, styles and add required components for Alpine and Phoenix hooks in main `*.js` file

```js
import "material-icons/iconfont/filled.css";
import "material-icons/iconfont/outlined.css";

import "phoenix_ui_components/style.css";
import "phoenix_ui_components/fonts.css";

import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";

import Alpine from "alpinejs";

import {
  dropdown,
  multiselect,
  pagination,
  FlashMessage,
} from "phoenix_ui_components";

window.Alpine = Alpine;

Alpine.data("dropdown", dropdown);
Alpine.data("multiselect", multiselect);
Alpine.data("pagination", pagination);

Alpine.start();

let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: {
    FlashMessage,
  },
});
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

1. Add `phoenix_ui_components` as dependency to the existing project.
2. Change `mix.exs` to track changes inside `deps/phoenix_ui_components`.
   ```diff
   -defp elixirc_paths(_), do: ["lib"]
   +defp elixirc_paths(_),
   +  do: ["lib", "deps/phoenix_ui_components/lib", "deps/phoenix_ui_components/priv/static/assets"]
   ```
3. Update any components inside `deps/phoenix_ui_components`.
4. Check new UI in the project web pages.
5. `deps/phoenix_ui_components` is a git repository, so you can commit changes directly from this directory and push it to GH.

If you want to change assets, then run inside `deps/phoenix_ui_components`

```term
mix assets.watch
```

If you wish to commit new assets, then bundle them and add to commit changes inside `priv/static/assets`

```term
mix assets.build
```
