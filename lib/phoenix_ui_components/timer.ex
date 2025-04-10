defmodule PhoenixUiComponents.Timer do
  use PhoenixUiComponents, :component
  import PhoenixUiComponents.Progress

  attr :progress, :float, required: true
  attr :text, :string, default: nil
  attr :color, :string, values: ["info"], default: "info"

  slot :inner_block

  def timer(assigns) do
    ~H"""
    <div class="relative flex items-center justify-center w-min">
      <.circular_progress
        progress={@progress}
        class="w-16 h-16"
        track_class={get_track_color_class(@color)}
        bar_class={get_bar_color_class(@color)}
      />
      <div class="absolute">
        <%= if @text do %>
          <span class="text-white text-sm font-bold">
            <%= @text %>
          </span>
        <% else %>
          <%= render_slot(@inner_block) %>
        <% end %>
      </div>
    </div>
    """
  end

  defp get_track_color_class("info"), do: "stroke-info-200"
  defp get_track_color_class("driving"), do: "stroke-driving-200"
  defp get_track_color_class("theory"), do: "stroke-theory-200"

  defp get_bar_color_class("info"), do: "stroke-info-400"
  defp get_bar_color_class("driving"), do: "stroke-driving-400"
  defp get_bar_color_class("theory"), do: "stroke-theory-400"
end
