defmodule PhoenixUiComponents.LocalePlugTest do
  use PhoenixUiComponents.ConnCase

  alias PhoenixUiComponents.LocalePlug
  alias Plug.Conn

  @moduletag :integration

  setup %{conn: conn} do
    conn =
      conn
      |> init_test_session(%{})

    {:ok, %{conn: conn}}
  end

  describe "plug" do
    test "set locale from params", %{conn: _conn} do
      locale = "en"

      conn =
        build_conn(:get, "/", locale: locale)
        |> init_test_session(%{})
        |> LocalePlug.call([])

      assert Gettext.get_locale(AbsenceWeb.Gettext) == locale
      assert get_session(conn, :locale) == locale
    end

    test "set locale from cookies", %{conn: conn} do
      locale = "en"

      conn =
        conn
        |> Conn.put_resp_cookie("app_locale", locale, [])
        |> fetch_cookies()
        |> LocalePlug.call([])

      assert Gettext.get_locale(AbsenceWeb.Gettext) == locale
      assert get_session(conn, :locale) == locale
    end

    test "set default locale", %{conn: conn} do
      locale = "de"

      conn = LocalePlug.call(conn, [])

      assert Gettext.get_locale(AbsenceWeb.Gettext) == locale
      assert get_session(conn, :locale) == locale
    end

    test "get locales from options", %{conn: conn} do
      conn =
        conn
        |> Conn.put_resp_cookie("app_locale", "en", [])
        |> fetch_cookies()
        |> LocalePlug.call(locales: ["uk", "de"])

      assert Gettext.get_locale(AbsenceWeb.Gettext) == "de"
      assert get_session(conn, :locale) == "de"
    end

    test "use default locale from options", %{conn: conn} do
      locale = "uk"

      conn = LocalePlug.call(conn, default_locale: locale)

      assert Gettext.get_locale(AbsenceWeb.Gettext) == locale
      assert get_session(conn, :locale) == locale
    end
  end
end
