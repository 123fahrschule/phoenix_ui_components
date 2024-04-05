defmodule PhoenixUiComponents.Example do
  use PhoenixUiComponents
  use PhoenixUiComponents, :component

  def example(assigns) do
    ~H"""
    <%= # <.spinner full_screen /> %>

    <.side_nav sections={
      [
        General: [
          %{
            label: "Dashboard",
            icon: :dashboard,
            items: [
              %{label: "Label 1", href: "#"},
              %{label: "Label 2", navigate: "#"},
              %{label: "Label 3", patch: "#"}
            ]
          },
          %{label: "Calendar", icon: :calendar_month, href: "#"},
          %{label: "Lessons", icon: :menu_book, href: "#"},
          %{label: "Notifications", icon: :notifications, href: "#"},
          %{label: "Students", icon: :badge, href: "#"}
        ],
        Other: [
          %{label: "Configurations", icon: :tune, href: "#"},
          %{label: "Settings", icon: :settings, href: "#"},
          %{label: "Label", icon: :image, href: "#"}
        ]
      ]
    } />

    <div class="py-10">
      <div class="px-10 space-y-4">
        <div>
          <h1>h1 Lorem ipsum dolor sit amet, consectet</h1>
          <h2>h2 Lorem ipsum dolor sit amet, consectet</h2>
          <h3>h3 Lorem ipsum dolor sit amet, consectet</h3>
          <h4>h4 Lorem ipsum dolor sit amet, consectet</h4>
          <h5>h5 Lorem ipsum dolor sit amet, consectet</h5>
          <h6>h6 Lorem ipsum dolor sit amet, consectet</h6>
        </div>

        <div>
          <p class="text-base">
            base Lorem <span class="font-semibold">ipsum</span> <span class="font-bold">dolor</span>
            <span class="italic">sit</span> amet, consectet
          </p>
          <p class="text-sm">
            sm Lorem <span class="font-semibold">ipsum</span> <span class="font-bold">dolor</span>
            <span class="italic">sit</span> amet, consectet
          </p>
          <p class="text-xs">
            xs Lorem <span class="font-semibold">ipsum</span> <span class="font-bold">dolor</span>
            <span class="italic">sit</span> amet, consectet
          </p>
        </div>

        <div>
          <.button label="button" size="sm" />
          <.button label="button" />
          <.button label="button" size="lg" />
          <.button label="button" disabled />
        </div>

        <div>
          <.button label="button" variant="secondary" size="sm" />
          <.button label="button" variant="secondary" />
          <.button label="button" variant="secondary" size="lg" />
          <.button label="button" variant="secondary" disabled />
        </div>

        <div>
          <.button label="button" variant="tertiary" size="sm" />
          <.button label="button" variant="tertiary" />
          <.button label="button" variant="tertiary" size="lg" />
          <.button label="button" variant="tertiary" disabled />
        </div>

        <div>
          <.button label="button" left_icon={:error} />
          <.button label="button" right_icon={:error} />
          <.button label="button" left_icon={:error} right_icon={:error} />
        </div>

        <div>
          <.button icon={:error} size="sm" />
          <.button icon={:error} />
          <.button icon={:error} size="lg" />
        </div>
      </div>

      <div class="px-10 mb-4 space-y-4">
        <.form for={:input} :let={f}>
          <.text_field form={f} field={:sm} label="Input sm" placeholder="Placeholder" size="sm" />
          <.text_field form={f} field={:md} label="Input md" placeholder="Placeholder" />
          <.text_field form={f} field={:lg} label="Input lg" placeholder="Placeholder" size="lg" />
        </.form>
      </div>

      <div class="px-10 mb-4 space-y-4">
        <.form for={:select} :let={f}>
          <.select native form={f} field={:sm} label="Select sm" size="sm" options={[]} />
          <.select native form={f} field={:md} label="Select md" options={[]} />
          <.select native form={f} field={:lg} label="Select lg" size="lg" options={[]} />
        </.form>
      </div>

      <div class="px-10 mb-4 space-y-4">
        <%= for size <- ["sm", "md", "lg"] do %>
          <%= for type <- ["info", "success", "warning", "error"] do %>
            <.banner
              type={type}
              size={size}
              label="Label"
              message="Lorem ipsum dolor sit amet, consectet"
              close_button_attributes={[]}
            />
          <% end %>
        <% end %>
      </div>
    </div>
    """
  end
end
