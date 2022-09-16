defmodule PhoenixUiComponents.Link do
  use PhoenixUiComponents, :component

  # attr :href, :string, default: nil
  # attr :patch, :string, default: nil
  # attr :navigate, :string, default: nil
  # attr :label, :string, default: nil
  def link(assigns) do
    assigns =
      assigns
      |> assign_new(:label, fn -> nil end)
      |> assign_rest([:label])

    ~H"""
    <.custom_link {@rest}>
      <%= if @label, do: @label, else: render_slot(@inner_block) %>
    </.custom_link>
    """
  end

  defp custom_link(%{href: _} = assigns) do
    assigns =
      assigns
      |> assign_rest([:href])

    ~H"""
    <%= Phoenix.HTML.Link.link([to: @href] ++ @rest) do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end

  defp custom_link(%{patch: _} = assigns) do
    assigns =
      assigns
      |> assign_rest([:patch])

    ~H"""
    <%= live_patch([to: @patch] ++ @rest)  do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end

  defp custom_link(%{navigate: _} = assigns) do
    assigns =
      assigns
      |> assign_rest([:navigate])

    ~H"""
    <%= live_redirect([to: @navigate] ++ @rest)  do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end

  defp custom_link(assigns) do
    assigns =
      assigns
      |> assign_rest([])

    ~H"""
    <button {@rest}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end
end
