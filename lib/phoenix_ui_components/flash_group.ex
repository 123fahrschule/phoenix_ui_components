defmodule PhoenixUiComponents.FlashGroup do
  use Phoenix.Component
  use Gettext, backend: PhoenixUiComponents.Gettext

  import PhoenixUiComponents.Banner

  alias Phoenix.LiveView.JS

  attr :flash, :map
  attr :size, :string, values: ["sm", "md", "lg"], default: "md"

  def flash_group(assigns) do
    ~H"""
    <div class="fixed inset-x-0 top-8 z-[60] px-4 pointer-events-none">
      <div class="mx-auto w-full max-w-[500px] flex flex-col gap-4">
        <.banner
          :for={{flash_type, flash_message} <- @flash}
          id={"flash_#{flash_type}"}
          phx-hook="FlashMessage"
          data-type={flash_type}
          phx-remove={
            JS.push("lv:clear-flash", value: %{key: flash_type}) |> hide("#flash_#{flash_type}")
          }
          message={flash_message}
          color={flash_type}
          on_close={
            JS.push("lv:clear-flash", value: %{key: flash_type}) |> hide("#flash_#{flash_type}")
          }
          class="shadow-small-300 break-all pointer-events-auto"
          size={@size}
        />

        <.banner
          id="client-error"
          phx-disconnected={show(".phx-client-error #client-error")}
          phx-connected={hide("#client-error")}
          hidden
          label={
            pgettext("flash message, live socket disconnected title", "We can't find the internet")
          }
          message={
            pgettext("flash message, live socket disconnected description", "Attempting to reconnect")
          }
          color="error"
          on_close={hide("#client-error")}
          class="hidden shadow-small-300 break-all pointer-events-auto"
          icon={:autorenew}
          icon_class="animate-spin"
          size={@size}
        />

        <.banner
          id="server-error"
          phx-disconnected={show(".phx-server-error #server-error")}
          phx-connected={hide("#server-error")}
          label={pgettext("flash message, live view crashed title", "Something went wrong!")}
          message={
            pgettext(
              "flash message, live view crashed description",
              "Hang in there while we get back on track"
            )
          }
          color="error"
          on_close={hide("#server-error")}
          class="hidden shadow-small-300 break-all pointer-events-auto"
          icon={:autorenew}
          icon_class="animate-spin"
          size={@size}
        />
      </div>
    </div>
    """
  end

  defp show(selector) do
    JS.show(
      to: selector,
      time: 300,
      display: "flex",
      transition:
        {"transition-all transform ease-out duration-300",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95",
         "opacity-100 translate-y-0 sm:scale-100"}
    )
  end

  defp hide(js \\ %JS{}, selector) do
    JS.hide(js,
      to: selector,
      time: 200,
      transition:
        {"transition-all transform ease-in duration-200",
         "opacity-100 translate-y-0 sm:scale-100",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"}
    )
  end
end
