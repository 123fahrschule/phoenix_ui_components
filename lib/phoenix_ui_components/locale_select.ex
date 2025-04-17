defmodule PhoenixUiComponents.LocaleSelect do
  use Phoenix.Component

  import PhoenixUiComponents.Dropdown
  import PhoenixUiComponents.Icon

  alias Phoenix.LiveView.JS

  attr :rest, :global

  def locale_select(assigns) do
    assigns =
      assigns
      |> assign(:current_locale, Gettext.get_locale())

    ~H"""
    <.dropdown
      id="locale-select"
      phx-hook="LocaleSelect"
      trigger_class="uppercase text-neutral-700 py-1 pl-1.5 pr-2 rounded-full flex items-center gap-0.5 bg-neutral-300 hover:bg-neutral-400 font-semibold text-body-xs"
      {@rest}
    >
      <.icon icon={:language} class="text-[16px]" />
      {@current_locale}

      <:menu>
        <ul>
          <li :for={
            {locale, text} <- [
              {"de", "Deutsch"},
              {"en", "English"}
            ]
          }>
            <.dropdown_item selected={locale == @current_locale}>
              <button
                phx-click={JS.dispatch("set-locale", to: "#locale-select", detail: %{locale: locale})}
                disabled={locale == @current_locale}
                class="flex-1 font-semibold text-neutral-900 px-3 py-2 text-start text-nowrap"
              >
                {text}
              </button>
            </.dropdown_item>
          </li>
        </ul>
      </:menu>
    </.dropdown>
    """
  end
end
