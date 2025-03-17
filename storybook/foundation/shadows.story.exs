defmodule Storybook.Foundation.Shadows do
  use PhoenixStorybook.Story, :page

  def render(assigns) do
    ~H"""
    <main class="space-y-10">
      <.section title="Shadows">
        <div
          :for={
            row <- [
              ["shadow-small-100", "shadow-small-200", "shadow-small-300", "shadow-small-400"],
              ["shadow-medium-100", "shadow-medium-200", "shadow-medium-300", "shadow-medium-400"],
              ["shadow-large-100", "shadow-large-200", "shadow-large-300", "shadow-large-400"]
            ]
          }
          class="flex gap-10"
        >
          <.shadow_card :for={class <- row} shadow={class} name={class} />
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
      <div class="space-y-10 pb-4">
        <%= render_slot(@inner_block) %>
      </div>
    </section>
    """
  end

  defp shadow_card(assigns) do
    ~H"""
    <div>
      <div class={["bg-neutral-100 size-40", @shadow]} />
      <p class="text-body-sm text-center px-1 py-3">
        <%= @name %>
      </p>
    </div>
    """
  end
end
