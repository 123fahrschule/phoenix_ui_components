defmodule Storybook.Foundation.BorderRadius do
  use PhoenixStorybook.Story, :page

  def render(assigns) do
    ~H"""
    <div class="flex flex-wrap gap-8">
      <div :for={
        {name, class} <- [
          {"4px", "rounded-4"},
          {"8px", "rounded-8"},
          {"12px", "rounded-12"},
          {"16px", "rounded-16"},
          {"24px", "rounded-24"}
        ]
      }>
        <div class={["bg-neutral-100 size-40 border border-neutral-300", class]} />
        <p class="text-body-sm text-center px-2 py-1">
          {name}
        </p>
      </div>
    </div>
    """
  end
end
