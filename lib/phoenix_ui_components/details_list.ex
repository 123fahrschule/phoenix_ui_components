defmodule PhoenixUiComponents.DetailsList do
  use PhoenixUiComponents, :component

  attr :class, :any, default: nil

  slot :item do
    attr :class, :any
    attr :term, :string, required: true
    attr :details, :string
  end

  def details_list(assigns) do
    ~H"""
    <dl class="divide-y divide-gray-200 ">
      <.details_list_item :for={item <- @item} {item}>
        {if item[:inner_block], do: render_slot(item)}
      </.details_list_item>
    </dl>
    """
  end

  attr :class, :any, default: nil
  attr :term, :string, required: true
  attr :details, :string, default: nil

  slot :inner_block

  def details_list_item(assigns) do
    ~H"""
    <div class="grid grid-cols-3 gap-4 px-6 py-3 odd:bg-gray-50 even:bg-white">
      <dt class="text-sm font-semibold">
        {@term}
      </dt>
      <dd class="col-span-2 text-sm">
        {if @details, do: @details, else: render_slot(@inner_block)}
      </dd>
    </div>
    """
  end
end
