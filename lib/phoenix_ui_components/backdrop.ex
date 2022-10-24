defmodule PhoenixUiComponents.Backdrop do
  use PhoenixUiComponents, :component

  attr(:class, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block)

  def backdrop(assigns) do
    ~H"""
    <div class={["fixed top-0 left-0 w-screen h-screen bg-black/25 z-[100]", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
