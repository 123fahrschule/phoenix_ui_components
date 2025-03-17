defmodule Storybook.Foundation.Colors do
  use PhoenixStorybook.Story, :page

  def render(assigns) do
    ~H"""
    <main class="space-y-4">
      <.section
        :for={
          {title, rows} <- [
            {"Primary Color",
             [
               [
                 "bg-primary-50",
                 "bg-primary-100",
                 "bg-primary-200",
                 "bg-primary-300",
                 "bg-primary-400",
                 "bg-primary-500",
                 "bg-primary-600"
               ]
             ]},
            {"Secondary Color",
             [
               [
                 "bg-secondary-50",
                 "bg-secondary-100",
                 "bg-secondary-200",
                 "bg-secondary-300",
                 "bg-secondary-400",
                 "bg-secondary-500",
                 "bg-secondary-600"
               ]
             ]},
            {"Neutral Colors",
             [
               [
                 "bg-neutral-100",
                 "bg-neutral-200",
                 "bg-neutral-300",
                 "bg-neutral-400",
                 "bg-neutral-500",
                 "bg-neutral-600",
                 "bg-neutral-700",
                 "bg-neutral-800",
                 "bg-neutral-900"
               ]
             ]},
            {"Semantic Colors",
             [
               [
                 "bg-warning-50",
                 "bg-warning-100",
                 "bg-warning-200",
                 "bg-warning-300",
                 "bg-warning-400",
                 "bg-warning-500"
               ],
               [
                 "bg-success-50",
                 "bg-success-100",
                 "bg-success-200",
                 "bg-success-300",
                 "bg-success-400",
                 "bg-success-500"
               ],
               [
                 "bg-error-50",
                 "bg-error-100",
                 "bg-error-200",
                 "bg-error-300",
                 "bg-error-400",
                 "bg-error-500"
               ],
               [
                 "bg-info-50",
                 "bg-info-100",
                 "bg-info-200",
                 "bg-info-300",
                 "bg-info-400",
                 "bg-info-500"
               ]
             ]},
            {"Supporting Colors",
             [
               [
                 "bg-driving-50",
                 "bg-driving-100",
                 "bg-driving-200",
                 "bg-driving-300",
                 "bg-driving-400",
                 "bg-driving-500"
               ],
               [
                 "bg-theory-50",
                 "bg-theory-100",
                 "bg-theory-200",
                 "bg-theory-300",
                 "bg-theory-400",
                 "bg-theory-500"
               ]
             ]},
            {"Gradients",
             [
               [
                 "bg-gradient-break",
                 "bg-gradient-driving",
                 "bg-gradient-theory",
                 "bg-gradient-exam",
                 "bg-gradient-vacation",
                 "bg-gradient-sick-leave"
               ]
             ]}
          ]
        }
        title={title}
      >
        <.colors_row :for={row <- rows}>
          <.color_card :for={class <- row} name={class_to_name(class)} class={class} />
        </.colors_row>
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

  defp colors_row(assigns) do
    ~H"""
    <div class="flex gap-4 flex-wrap">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  defp color_card(assigns) do
    ~H"""
    <div class="bg-neutral-100 shadow-medium-100">
      <div class={["w-44 h-32", @class]} />
      <p class="text-body-sm text-center px-4 py-3">
        <%= @name %>
      </p>
    </div>
    """
  end

  defp class_to_name("bg-" <> name), do: name
end
