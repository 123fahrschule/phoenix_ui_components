defmodule PhoenixUiComponents do
  def component() do
    quote do
      import Phoenix.Component
      use Phoenix.Component, global_prefixes: ~w(x-)

      import PhoenixUiComponents.Helpers
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  defmacro __using__(_) do
    quote do
      import PhoenixUiComponents.{
        Avatar,
        Backdrop,
        Badge,
        Banner,
        Button,
        Card,
        Checkbox,
        CustomLink,
        Form,
        Icon,
        Layout,
        SideNav,
        Spinner,
        TopNav,
        Typography
      }
    end
  end
end
