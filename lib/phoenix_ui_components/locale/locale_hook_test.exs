defmodule PhoenixUiComponents.LocaleHookTest do
  use PhoenixUiComponents.ConnCase

  alias Phoenix.LiveView
  alias PhoenixUiComponents.LocaleHook

  @moduletag :integration

  setup %{conn: conn} do
    conn =
      conn
      |> init_test_session(%{})

    {:ok, %{conn: conn}}
  end

  describe "on_mount :restore_locale" do
    test "set locale from session", %{conn: conn} do
      locale = "de"

      assert Gettext.get_locale() == "en"

      session =
        conn
        |> put_session(:locale, locale)
        |> get_session()

      {:cont, _updated_socket} =
        LocaleHook.on_mount(:default, %{}, session, %LiveView.Socket{})

      assert Gettext.get_locale() == locale
    end
  end
end
