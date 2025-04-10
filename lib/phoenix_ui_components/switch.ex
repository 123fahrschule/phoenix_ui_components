defmodule PhoenixUiComponents.Switch do
  use PhoenixUiComponents, :component
  use PhoenixHTMLHelpers

  import PhoenixUiComponents.Icon

  attr :form, :any, required: true
  attr :field, :atom, required: true
  attr :class, :string, default: nil
  attr :container_class, :string, default: nil
  attr :icon, :atom, default: nil
  attr :rest, :global, include: ["required", "checked", "disabled"]

  slot :inner_block

  def switch(assigns) do
    ~H"""
    <div class={[
      "relative inline-flex items-center justify-center flex-shrink-0 w-[52px] h-8 group mr-2",
      @container_class
    ]}>
      <%= checkbox(
        @form,
        @field,
        [
          class: [
            "absolute w-[52px] h-8 bg-white border-none rounded-full cursor-pointer peer checked:border-0 checked:bg-transparent checked:focus:bg-transparent checked:hover:bg-transparent focus:ring-primary-300",
            @class
          ]
        ] ++ assigns_to_attributes(@rest)
      ) %>
      <span class="absolute h-8 w-[52px] mx-auto transition-colors duration-200 ease-in-out bg-neutral-200 pointer-events-none border border-2 border-neutral-400 rounded-full peer-checked:border-primary-300 peer-checked:peer-disabled:border-neutral-300 peer-checked:bg-primary-300 peer-disabled:bg-neutral-300 peer-disabled:peer-checked:bg-neutral-300 peer-disabled:bg-neutral-100 peer-disabled:border-neutral-200">
      </span>
      <span class="inline-flex items-center justify-center absolute left-1 top-1 inline-block w-6 h-6 transition-transform duration-200 ease-in-out transform translate-x-0 bg-neutral-400 rounded-full shadow pointer-events-none peer-checked:bg-neutral-100 peer-checked:translate-x-5 ring-0 peer-disabled:bg-neutral-300 peer-disabled:peer-checked:bg-neutral-200 text-neutral-300 peer-checked:text-primary-300 peer-disabled:peer-checked:text-neutral-300">
        <.icon :if={@icon} icon={@icon} class="text-[16px]" />
      </span>
    </div>
    """
  end
end
