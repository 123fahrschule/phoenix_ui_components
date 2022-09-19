defmodule PhoenixUiComponents.Layout do
  use PhoenixUiComponents, :component

  # slot :head, default: []
  # slot :inner_block, required: true
  def root_layout(assigns) do
    assigns = assigns |> assign_slot(:head)

    ~H"""
    <!DOCTYPE html>
    <html lang="de" class="h-full">
      <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <%= render_slot(@head) %>
        <style>
          [x-cloak] { display: none !important; }
          .material-icons, .material-icons-outlined {
              min-width: 1em;
              max-width: 1em;
              overflow: hidden;
            }
        </style>
      </head>
      <body class="h-full bg-white text-neutral-900">
        <%= render_slot(@inner_block) %>
      </body>
    </html>
    """
  end

  # attr :class, :string, default: nil
  # attr :rest, :global
  # slot :inner_block, required: true
  def page_content(assigns) do
    assigns =
      assigns
      |> assign_class
      |> assign_rest([:class])

    ~H"""
    <div class={["ml-64", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
