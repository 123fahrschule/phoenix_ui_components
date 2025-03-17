defmodule Storybook.Components.Modal do
  use PhoenixStorybook.Story, :component

  alias PhoenixUiComponents.Button
  alias PhoenixUiComponents.Modal

  def imports,
    do: [
      {
        Modal,
        fullscreen_modal_header: 1,
        modal_actions: 1,
        modal_header_icon: 1,
        modal_subtitle: 1,
        modal_title: 1
      },
      {Button, button: 1}
    ]

  def function, do: &Modal.modal/1

  @simple_modal """
  <.modal_title text="Modal title" />
  <p>
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Natus maiores nam libero nihil ab id esse consequuntur optio similique explicabo saepe, numquam officia minima praesentium animi, corrupti inventore ipsum? Non!"
  </p>
  <.modal_actions>
    <.button primary phx-click="confirm">Confirm</.button>
  </.modal_actions>
  """

  def variations,
    do: [
      %Variation{
        id: :simple_modal,
        attributes: %{
          show: false
        },
        slots: [@simple_modal],
        template: """
        <div psb-code-hidden>
          <button phx-click={JS.exec("data-show", to: "#modal-single-simple-modal")}>
            Show modal
          </button>
          <.psb-variation/>
        </div>
        """
      },
      %Variation{
        id: :advanced_modal,
        attributes: %{
          show: false
        },
        slots: [
          """
          <.modal_header_icon icon={:info} class="text-info-300" />
          <div class="text-center space-y-2">
          <.modal_title text="Modal title" />
          <.modal_subtitle text="Modal subtitle" />
          </div>
          <p>
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Natus maiores nam libero nihil ab id esse consequuntur optio similique explicabo saepe, numquam officia minima praesentium animi, corrupti inventore ipsum? Non!"
          </p>
          <.modal_actions class="md:!justify-center">
            <.button secondary phx-click="cancel">Cancel</.button>
            <.button primary phx-click="confirm">Confirm</.button>
          </.modal_actions>
          """
        ],
        template: """
        <div psb-code-hidden>
          <button phx-click={JS.exec("data-show", to: "#modal-single-advanced-modal")}>
            Show modal
          </button>
          <.psb-variation/>
        </div>
        """
      },
      %Variation{
        id: :desktop_sm,
        description: "Small size on desktop",
        attributes: %{
          show: false,
          sizes: %{
            desktop: "sm"
          }
        },
        slots: [@simple_modal],
        template: """
        <div psb-code-hidden>
          <button phx-click={JS.exec("data-show", to: "#modal-single-desktop-sm")}>
            Show modal
          </button>
          <.psb-variation/>
        </div>
        """
      },
      %Variation{
        id: :fullscreen,
        description: "Fullscreen size on mobile",
        attributes: %{
          show: false,
          sizes: %{
            mobile: "fullscreen"
          }
        },
        template: """
        <div psb-code-hidden>
          <button phx-click={JS.exec("data-show", to: "#modal-single-fullscreen")}>
            Show modal
          </button>
          <.psb-variation/>
        </div>
        """,
        slots: [
          """
          <div class="gap-2 items-center hidden md:flex">
            <.modal_title text="Modal title" />
          </div>

          <.fullscreen_modal_header
          class="md:hidden"
          title="Modal title"
          on_close={JS.exec("data-hide", to: "#modal-single-fullscreen")}
          />

          <div class="px-4 md:px-0 space-y-6">
            <p>
              "Lorem ipsum dolor sit amet consectetur adipisicing elit. Natus maiores nam libero nihil ab id esse consequuntur optio similique explicabo saepe, numquam officia minima praesentium animi, corrupti inventore ipsum? Non!"
            </p>
            <.modal_actions>
              <.button primary phx-click="confirm">Confirm</.button>
            </.modal_actions>
          </div>
          """
        ]
      }
    ]
end
