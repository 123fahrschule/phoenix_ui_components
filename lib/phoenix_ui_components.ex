defmodule PhoenixUiComponents do
  def component() do
    quote do
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
        Breadcrumbs,
        Button,
        Card,
        CustomLink,
        DataTable,
        DetailsList,
        DevTools,
        Dropdown,
        Flyout,
        FormField,
        Icon,
        Layout,
        LocaleSelect,
        Modal,
        MultiselectAlpine,
        Page,
        Pagination,
        Progress,
        SideNav,
        Sidebar,
        Spinner,
        Stepper,
        Table,
        Tabs,
        Timer,
        Tooltip,
        TopNav,
        Topbar
      }
    end
  end
end
