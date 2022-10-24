defmodule PhoenixUiComponents.Helpers do
  import Phoenix.Component

  def assign_attr(assigns, attr, default_value \\ nil) do
    assign_new(assigns, attr, fn -> default_value end)
  end

  def assign_class(assigns, default_class \\ nil) do
    assign_new(assigns, :class, fn -> default_class end)
  end

  def assign_rest(assigns, exclude \\ []) do
    assign_new(assigns, :rest, fn -> assigns_to_attributes(assigns, exclude) end)
  end

  def assign_slot(assigns, slot, default_value \\ []) do
    assign_new(assigns, slot, fn -> default_value end)
  end
end
