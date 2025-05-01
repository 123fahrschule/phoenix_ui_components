# PhoenixUiComponents

## Installation

The package can be installed by adding `phoenix_ui_components` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phoenix_ui_components, github: "123fahrschule/phoenix_ui_components", tag: "1.5.0"}
  ]
end
```

Configure [Tailwind](https://github.com/phoenixframework/tailwind) and [Esbuild](https://github.com/phoenixframework/esbuild)

Install required node modules inside `assets`

```term
npm install alpinejs@3.10.3 --prefix ./assets --save-exact
```

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

Import icons, styles and add required components for Alpine and Phoenix hooks in main `*.js` file

```js
import 'phoenix_ui_components/fonts.css';
import 'phoenix_ui_components/material-icons.css';

import { Socket } from 'phoenix';
import { LiveSocket } from 'phoenix_live_view';

import Alpine from 'alpinejs';

import { dropdown, multiselect, pagination, FlashMessage } from 'phoenix_ui_components';

window.Alpine = Alpine;

Alpine.data('dropdown', dropdown);
Alpine.data('multiselect', multiselect);
Alpine.data('pagination', pagination);

Alpine.start();

let liveSocket = new LiveSocket('/live', Socket, {
  params: { _csrf_token: csrfToken },
  hooks: {
    FlashMessage
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
