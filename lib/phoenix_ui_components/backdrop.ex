defmodule PhoenixUiComponents.Backdrop do
  use PhoenixUiComponents, :component

  # attr :class, :string, default: nil
  # attr :rest, :global, default: nil
  # slot :inner_block, required: true
  def backdrop(assigns) do
    assigns =
      assigns
      |> assign_class
      |> assign_rest([:class])

    ~H"""
    <div class="fixed top-0 left-0 w-screen h-screen bg-black/25" {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
