defmodule Storybook.Foundation.Typography do
  use PhoenixStorybook.Story, :page

  def render(assigns) do
    ~H"""
    <main class="space-y-4">
      <.section title="Titles">
        <h1 class="text-h1">H1 - Lorem ipsum dolor sit amet</h1>
        <h2 class="text-h2">H2 - Lorem ipsum dolor sit amet</h2>
        <h3 class="text-h3">H3 - Lorem ipsum dolor sit amet</h3>
        <h4 class="text-h4">H4 - Lorem ipsum dolor sit amet</h4>
        <h5 class="text-h5">H5 - Lorem ipsum dolor sit amet</h5>
        <h6 class="text-h6">H6 - Lorem ipsum dolor sit amet</h6>
      </.section>

      <.section title="Body text">
        <p :for={class <- ["text-body", "text-body-sm", "text-body-xs"]} class={class}>
          Lorem ipsum dolor, sit amet consectetur adipisicing elit. Voluptatum, ut! Officia explicabo dolorem consectetur similique et dicta nulla nobis deleniti, odio esse? Quo enim voluptate sit quas maxime natus dignissimos.
        </p>
      </.section>

      <.section title="Button text">
        <button class="text-button-lg">Button large</button>
        <br />
        <button class="text-button">Button medium</button>
        <br />
        <button class="text-button-sm">Button small</button>
      </.section>

      <.section title="Font weights">
        <div :for={
          class <- [
            "font-thin",
            "font-extralight",
            "font-light",
            "font-normal",
            "font-medium",
            "font-semibold",
            "font-bold",
            "font-extrabold",
            "font-black"
          ]
        }>
          <p class="text-body"><%= class %></p>
          <p class={["text-body", class]}>
            Lorem ipsum dolor, sit amet consectetur adipisicing elit. Voluptatum, ut! Officia explicabo dolorem consectetur similique et dicta nulla nobis deleniti, odio esse? Quo enim voluptate sit quas maxime natus dignissimos.
          </p>
        </div>
      </.section>
    </main>
    """
  end

  def section(assigns) do
    ~H"""
    <section>
      <h1 class="border-b-2 border-neutral-400 text-h2 mb-4">
        <%= @title %>
      </h1>
      <div class="space-y-4 pb-4">
        <%= render_slot(@inner_block) %>
      </div>
    </section>
    """
  end
end
