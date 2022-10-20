defmodule PhoenixUiComponents do
  def component() do
    quote do
      import Phoenix.Component
      use Phoenix.Component, global_prefixes: ~w(x-)

      import PhoenixUiComponents.Helpers
      alias PhoenixUiComponents.Icons.MaterialIcons
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  defmacro __using__(_) do
    quote do
      alias PhoenixUiComponents.Icons.MaterialIcons

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
        Layout,
        SideNav,
        Spinner,
        TopNav,
        Typography
      }
    end
  end
end
