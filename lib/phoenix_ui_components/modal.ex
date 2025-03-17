defmodule PhoenixUiComponents.Modal do
  @moduledoc """
  A component for displaying modal dialogs in the application.

  This module provides functionality to create and manage modal dialogs,
  allowing for user interactions without navigating away from the current page.
  """

  use Phoenix.Component

  alias Phoenix.LiveView.JS

  import PhoenixUiComponents.Icon
  import PhoenixUiComponents.Helpers

  @doc """
    Renders a modal.

    ## Examples

        <.modal id="confirm-modal" on_cancel={JS.push("close_modal")}>
          <.modal_title text="Modal title" />
          <!-- Modal content -->
          <.modal_actions>
            <.button primary phx-click="confirm">Confirm</.button>
          </.modal_actions>
        </.modal>

    With header icon and centered title and subtitle

        <.modal id="confirm-modal" on_cancel={JS.push("close_modal")}>
          <.modal_header_icon icon={:check_circle} class="text-success-300" />
          <div class="text-center space-y-2">
            <.modal_title text="Modal title" />
            <.modal_subtitle text="Modal subtitle" />
          </div>
          <!-- Modal content -->
          <.modal_actions>
            <.button secondary phx-click="cancel">Cancel</.button>
            <.button primary phx-click="confirm">Confirm</.button>
          </.modal_actions>
        </.modal>

  """

  attr(:id, :string, required: true)
  attr(:show, :boolean, default: true)
  attr(:on_cancel, JS, default: %JS{})
  attr(:sizes, :map, default: %{}, examples: [%{mobile: "fullscreen", desktop: "sm"}])
  attr(:close_button_class, :any, default: nil)
  attr(:class, :any, default: nil)
  slot(:inner_block, required: true)

  def modal(assigns) do
    ~H"""
    <div
      id={@id}
      phx-mounted={@show && JS.exec("data-show")}
      phx-remove={JS.exec("data-hide")}
      data-show={show_modal(@id, @sizes)}
      data-hide={hide_modal(@on_cancel, @id, @sizes)}
      class="fixed z-50 hidden"
    >
      <div
        id={"#{@id}-backdrop"}
        class="fixed inset-0 bg-neutral-800/50 hidden"
        aria-hidden="true"
        phx-click={JS.exec("data-hide", to: "##{@id}")}
      />

      <div
        class="fixed inset-0 overflow-y-auto pointer-events-none"
        role="dialog"
        aria-modal="true"
        tabindex="0"
      >
        <div class="flex min-h-full items-center justify-center">
          <.focus_wrap
            id={"#{@id}-container"}
            phx-window-keydown={JS.exec("data-hide", to: "##{@id}")}
            phx-key="escape"
            class={[
              "hidden bg-neutral-100 shadow-small-400 border border-neutral-300 text-neutral-900 fixed w-full overflow-y-auto pointer-events-auto",
              case @sizes[:mobile] do
                "fullscreen" -> "inset-0"
                _ -> "bottom-0 inset-x-0 rounded-t-2xl max-h-[90vh] p-6"
              end,
              case @sizes[:desktop] do
                "fullscreen" -> "md:inset-0"
                "sm" -> "md:max-w-[400px]"
                _md -> "md:max-w-[560px]"
              end,
              case @sizes[:desktop] do
                "fullscreen" ->
                  nil

                _shared_desktop_styles ->
                  "md:inset-auto md:max-h-[90vh] md:rounded-2xl md:px-8 md:py-6"
              end
            ]}
          >
            <button
              type="button"
              class={[
                "absolute top-6 right-8 p-1 inline-flex rounded-full text-neutral-900 hover:bg-neutral-200 focus:bg-neutral-200 focus-within:outline-neutral-300",
                @sizes[:mobile] == "fullscreen" && "max-md:hidden",
                @sizes[:desktop] == "fullscreen" && "md:hidden",
                @close_button_class
              ]}
              phx-click={JS.exec("data-hide", to: "##{@id}")}
            >
              <.icon icon={:close} class="text-[24px]" />
            </button>

            <div id={"#{@id}-content"} class={["space-y-4", @class]}>
              <%= render_slot(@inner_block) %>
            </div>
          </.focus_wrap>
        </div>
      </div>
    </div>
    """
  end

  attr(:class, :any, default: nil)
  attr(:title, :string)
  attr(:on_close, JS, default: %JS{})
  attr(:rest, :global)

  slot(:inner_block)

  def fullscreen_modal_header(assigns) do
    ~H"""
    <div
      class={[
        "bg-neutral-100 shadow-small-300 p-1 pt-2 flex items-center gap-0.5 !mt-0",
        @class
      ]}
      {@rest}
    >
      <button
        type="button"
        class="inline-flex p-2 rounded-full hover:bg-neutral-200 focus-visible:outline-none focus-visible:bg-neutal-200"
        phx-click={@on_close}
      >
        <.icon icon={:arrow_back} class="text-neutral-900 text-[24px]" />
      </button>
      <p class="text-h5 text-neutral-900 flex-grow text-center">
        <%= @title %>
      </p>

      <div class="w-10" />
    </div>
    """
  end

  attr(:icon, :any, default: nil)
  attr(:class, :any, default: nil)
  attr(:rest, :global, include: ["outlined"])

  def modal_header_icon(assigns) do
    ~H"""
    <div class="flex items-center justify-center">
      <.icon icon={@icon} class={list_class_value(["text-[80px]", @class])} {@rest} />
    </div>
    """
  end

  attr(:class, :any, default: nil)
  attr(:text, :string, default: nil)
  attr(:rest, :global)

  def modal_title(assigns) do
    ~H"""
    <p class={["text-h4", @class]} {@rest}>
      <%= @text %>
    </p>
    """
  end

  attr(:class, :any, default: nil)
  attr(:text, :string, default: nil)
  attr(:rest, :global)

  def modal_subtitle(assigns) do
    ~H"""
    <p class={["text-body-sm text-neutral-700", @class]} {@rest}>
      <%= @text %>
    </p>
    """
  end

  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block)

  def modal_actions(assigns) do
    ~H"""
    <div class={["flex flex-col gap-4 md:flex-row md:justify-end pb-8 md:pb-0", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  defp show_modal(js \\ %JS{}, id, sizes) when is_binary(id) do
    js
    |> JS.push_focus()
    |> JS.add_class("overflow-hidden", to: "body")
    |> JS.show(to: "##{id}")
    |> JS.show(
      to: "##{id}-backdrop",
      transition: {
        "transition-opacity ease-out duration-300",
        "opacity-0",
        "opacity-100"
      },
      time: 300
    )
    |> JS.show(
      to: "##{id}-container",
      transition: {
        "transition-all ease-out duration-300",
        "#{if(sizes[:mobile] == "fullscreen", do: "max-md:translate-x-full", else: "max-md:translate-y-full ")} md:opacity-0 md:scale-95",
        "#{if(sizes[:mobile] == "fullscreen", do: "max-md:translate-x-0", else: "max-md:translate-y-0 ")} md:opacity-100 md:scale-100"
      },
      time: 300
    )
    |> JS.focus_first(to: "##{id}-content")
  end

  defp hide_modal(js, id, sizes) do
    js
    |> JS.hide(
      to: "##{id}-container",
      transition: {
        "transition-all ease-in duration-200",
        "#{if(sizes[:mobile] == "fullscreen", do: "max-md:translate-x-0", else: "max-md:translate-y-0")} md:opacity-100 md:scale-100",
        "#{if(sizes[:mobile] == "fullscreen", do: "max-md:translate-x-full", else: "max-md:translate-y-full")} md:opacity-0 md:scale-95"
      }
    )
    |> JS.hide(
      to: "##{id}-backdrop",
      transition: {
        "transition-opacity ease-in duration-200",
        "opacity-100",
        "opacity-0"
      }
    )
    |> JS.hide(transition: "delay", time: 300)
    |> JS.remove_class("overflow-hidden", to: "body")
    |> JS.pop_focus()
  end
end
