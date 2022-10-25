defmodule PhoenixUiComponents.Breadcrumbs do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Icon

  attr(:breadcrumbs, :list,
    required: true,
    examples: [
      [
        %{label: "Link", icon: :info, href: "#"},
        %{label: "Live patch", patch: "#"},
        %{label: "Live redirect", navigate: "#", active: true}
      ]
    ]
  )

  attr(:class, :string, default: nil)
  attr(:rest, :global)

  def breadcrumbs(assigns) do
    ~H"""
    <div class={["flex items-center", @class]} {@rest}>
      <.intersperse :let={item} enum={@breadcrumbs}>
        <:separator>
          <.icon icon={:chevron_right} class="text-neutral-700 text=[16px] mx-1" />
        </:separator>
        <.breadcrumb {item} />
      </.intersperse>
    </div>
    """
  end

  attr(:icon, :atom, default: nil)
  attr(:label, :string, required: true)
  attr(:rest, :global)

  def breadcrumb(%{rest: rest} = assigns)
      when is_map_key(rest, :href)
      when is_map_key(rest, :navigate)
      when is_map_key(rest, :patch) do
    ~H"""
    <.link class={["flex items-center text-sm text-neutral-700 hover:text-neutral-800"]} {@rest}>
      <.icon :if={@icon} icon={@icon} class="text=[24px] mr-1" outlined />
      <%= @label %>
    </.link>
    """
  end

  def breadcrumb(assigns) do
    ~H"""
    <span class={["flex items-center text-sm text-neutral-900"]} {@rest}>
      <.icon :if={@icon} icon={@icon} class="text=[24px] mr-1" outlined />
      <%= @label %>
    </span>
    """
  end
end
