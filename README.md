# PhoenixUiComponents

## Installation

The package can be installed by adding `phoenix_ui_components` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phoenix_ui_components, github: "123fahrschule/phoenix_ui_components", tag: "0.1.0"}
  ]
end
```

Configure [Tailwind](https://github.com/phoenixframework/tailwind) and [Esbuild](https://github.com/phoenixframework/esbuild)

Add preset to the tailwind config file and add path to package in content section

```js
// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

module.exports = {
  presets: [require('../deps/phoenix_ui_components').preset],
  content: [
    // ...
    '../deps/phoenix_ui_components/**/*.*ex',
    '../deps/phoenix_ui_components/priv/static/**/*.*js'
  ]
};
```

Import `styles.css` at the top of the tailwind .css file

```css
@import "../../deps/phoenix_ui_components/priv/static/styles.css";

// rest of tailwind config
```

Import icons, styles and Phoenix hooks in main `*.js` file

```js
import 'phoenix_ui_components/fonts.css';
import 'phoenix_ui_components/material-icons.css';

import { Socket } from 'phoenix';
import { LiveSocket } from 'phoenix_live_view';

import {
  DropdownMenu,
  FlashMessage,
  LocaleSelect,
  Pagination,
  Sidebar,
  Tooltip
} from 'phoenix_ui_components';

let liveSocket = new LiveSocket('/live', Socket, {
  params: { _csrf_token: csrfToken },
  hooks: {
    DropdownMenu,
    FlashMessage,
    LocaleSelect,
    Pagination,
    Sidebar,
    Tooltip
  }
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

## Local development

1. Install required dependencies

   ```term
   mix setup
   ```

1. Start dev server

   ```term
   mix dev
   ```

1. Open `localhost:4000`. In the root path you can find Storybook with components and their usages
1. Update any components inside `lib/phoenix_ui_components` and/or update story for this component.
1. Check update in the Storybook.

If you wish to commit new assets, then bundle them and add to commit changes inside `priv/static/assets`

```term
mix assets.build
```
