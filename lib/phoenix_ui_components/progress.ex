defmodule PhoenixUiComponents.Progress do
  use PhoenixUiComponents, :component

  attr(:progress, :float, required: true)
  attr(:class, :string, default: nil)
  attr(:track_class, :string, default: nil)
  attr(:bar_class, :string, default: nil)
  attr(:rest, :global)

  def circular_progress(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      version="1.1"
      viewBox="0 0 64 64"
      class={["overflow-visible", @class]}
      {@rest}
    >
      <circle
        r="28"
        cx="32"
        cy="32"
        fill="transparent"
        class={[
          "stroke-info-200 stroke-[8px]",
          @track_class
        ]}
      />
      <circle
        r="28"
        cx="32"
        cy="32"
        fill="transparent"
        stroke-linecap="round"
        stroke-dasharray="175.93"
        stroke-dashoffset="0"
        class={[
          "stroke-[8px] [transition:stroke-dashoffset_1s_ease-in-out] -rotate-90 origin-center",
          @bar_class
        ]}
        style={"stroke-dashoffset: #{get_progress_circle_offset(@progress)};"}
      />
      <circle
        r="6"
        cx={progress_dot_x_position(@progress)}
        cy={progress_dot_y_position(@progress)}
        class="fill-neutral-100 shadow-sm-3"
      />
    </svg>
    """
  end

  defp get_progress_circle_offset(progress) do
    radius = 28

    (100 - progress) / 100 * :math.pi() * radius * 2
  end

  defp progress_dot_x_position(progress) do
    radius = 28
    center_x = 32
    radians = angle_in_radians(progress)

    center_x + radius * :math.cos(radians)
  end

  defp progress_dot_y_position(progress) do
    radius = 28
    center_y = 32
    radians = angle_in_radians(progress)

    center_y + radius * :math.sin(radians)
  end

  defp angle_in_radians(progress), do: (360 / 100 * progress - 90) * :math.pi() / 180
end
