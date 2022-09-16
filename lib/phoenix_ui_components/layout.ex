defmodule PhoenixUiComponents.Layout do
  use PhoenixUiComponents, :component

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
