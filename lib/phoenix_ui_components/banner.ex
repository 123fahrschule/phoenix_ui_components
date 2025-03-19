defmodule PhoenixUiComponents.Banner do
  use Phoenix.Component

  import PhoenixUiComponents.Icon

  @colors ["info", "success", "warning", "error"]
  @sizes ["sm", "md", "lg"]

  # Tailwind safelist
  # banner-sm banner-md banner-lg
  # banner-info banner-success banner-warning banner-error

  attr(:class, :string, default: nil)
  attr(:color, :string, values: @colors, default: "info")

  attr(:type, :any,
    values: [nil | @colors],
    default: nil,
    doc: "Deprecated. Use `color` instead"
  )

  attr(:size, :string, values: @sizes, default: "md")
  attr(:label, :string, default: nil)
  attr(:message, :string, default: nil)
  attr(:on_close, JS, default: nil)
  attr(:close_button_attributes, :list, default: [])
  attr(:rest, :global)

  def banner(assigns) do
    ~H"""
    <div role="alert" class={["banner banner-#{@type || @color} banner-#{@size}", @class]} {@rest}>
      <div class="banner-icon-container">
        <.icon icon={get_icon(@type || @color)} class="banner-icon" />
      </div>
      <div class="flex-grow">
        <p :if={@label} class="banner-label">
          <%= @label %>
        </p>
        <p :if={@message} class="banner-message">
          <%= @message %>
        </p>
      </div>
      <button
        :if={@on_close}
        type="button"
        phx-click={@on_close}
        class="close-button"
        {@close_button_attributes}
      >
        <.icon icon={:close} class="text-[16px]" />
      </button>
    </div>
    """
  end

  defp get_icon("info"), do: :info
  defp get_icon("success"), do: :check_circle
  defp get_icon("warning"), do: :warning
  defp get_icon("error"), do: :error
end
