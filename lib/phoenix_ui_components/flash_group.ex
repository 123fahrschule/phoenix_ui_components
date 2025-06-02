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
        <div
          :for={{flash_type, flash_message} <- @flash}
          id={"flash_#{flash_type}"}
          phx-hook="FlashMessage"
          data-type={flash_type}
          phx-remove={
            JS.push("lv:clear-flash", value: %{key: flash_type}) |> hide("#flash_#{flash_type}")
          }
        >
          <.banner
            message={flash_message}
            color={flash_type}
            on_close={
              JS.push("lv:clear-flash", value: %{key: flash_type}) |> hide("#flash_#{flash_type}")
            }
            class="shadow-small-300 break-all pointer-events-auto"
            size={@size}
          />
        </div>

        <div
          id="client-error"
          phx-disconnected={JS.remove_attribute("hidden", to: ".phx-client-error #client-error")}
          phx-connected={JS.set_attribute({"hidden", ""})}
          hidden
        >
          <.banner
            label={
              pgettext("flash message, live socket disconnected title", "We can't find the internet")
            }
            message={
              pgettext(
                "flash message, live socket disconnected description",
                "Attempting to reconnect"
              )
            }
            color="error"
            on_close={JS.exec("phx-connected", to: "#client-error")}
            class="shadow-small-300 break-all pointer-events-auto"
            icon={:autorenew}
            icon_class="motion-safe:animate-spin"
            size={@size}
          />
        </div>

        <div
          id="server-error"
          phx-disconnected={JS.remove_attribute("hidden", to: ".phx-server-error #server-error")}
          phx-connected={JS.set_attribute({"hidden", ""})}
          hidden
        >
          <.banner
            label={pgettext("flash message, live view crashed title", "Something went wrong!")}
            message={
              pgettext(
                "flash message, live view crashed description",
                "Hang in there while we get back on track"
              )
            }
            color="error"
            on_close={JS.exec("phx-connected", to: "#server-error")}
            class="shadow-small-300 break-all pointer-events-auto"
            icon={:autorenew}
            icon_class="motion-safe:animate-spin"
            size={@size}
          />
        </div>
      </div>
    </div>
    """
  end

  defp hide(js, selector) do
    JS.hide(js,
      to: selector,
      time: 200,
      transition: {
        "transition-all ease-in duration-200",
        "opacity-100 translate-y-0 sm:scale-100",
        "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
      }
    )
  end
end
