defmodule PhoenixUiComponents.Example do
  use PhoenixUiComponents
  use PhoenixUiComponents, :component

  def example(assigns) do
    ~H"""
    <.admin_layout app_name="Example" root_path="#" nav_sections={side_nav_sections()}>
      <:side_nav_footer>
        <span class="text-white">
          Footer
        </span>
      </:side_nav_footer>
      <:top_nav_content>
        <.form :let={f} for={:search} class="mx-auto">
          <.form_field form={f} field={:search} placeholder="Search ..." />
        </.form>
        <.sunrise_sunset sunrise="08:00" sunset="22:00" class="ml-auto mr-6" />
        <div class="flex mr-14 rounded-full p-1">
          <.avatar />
        </div>
      </:top_nav_content>
      <div class="p-10">
        <.breadcrumbs breadcrumbs={breadcrumbs()} class="mb-4" />

        <.tabs class="mb-4">
          <.tab active label="Active Tab" />
          <.tab>
            Inactive Tab
          </.tab>
          <.tab icon={:image}>
            Tab with icon
          </.tab>
        </.tabs>

        <.stepper class="mb-4">
          <.step index={1} label="One" state="active" />
          <.step index={2} label="Two" />
          <.step index={3} label="Three" state="completed" />
        </.stepper>

        <.pagination
          current_page={5}
          total_pages={10}
          total_records={100}
          current_records={50}
          navigation_type="patch"
        />

        <.flyout
          class="mb-4"
          title="TItle"
          description="lorem ipsum dolor sit amet, consectet"
          close_button_attrs={[]}
          new_tab_url="/"
        >
          <:footer>
            <div class="flex justify-between">
              <.button label="Cancel" tertiary />
              <.button label="Confirm" primary />
            </div>
          </:footer>
        </.flyout>

        <div class="flex mb-4 space-x-4">
          <.data_table_label arrows label="Label" />
          <.data_table_label arrows active label="Active" />
        </div>

        <div
          x-data="{ showSpinner: false }"
          x-on:keyup.escape.window="showSpinner = false"
          class="mb-4"
        >
          <.button label="Toggle spinner" x-on:click="showSpinner = true" />
          <.spinner
            full_screen
            x-on:click.outside="showSpinner = false"
            backdrop_attrs={["x-show": "showSpinner", "x-cloak": true]}
          />
        </div>

        <div class="space-y-4">
          <div>
            <.h1>h1 Lorem ipsum dolor sit amet, consectet</.h1>
            <.h2>h2 Lorem ipsum dolor sit amet, consectet</.h2>
            <.h3>h3 Lorem ipsum dolor sit amet, consectet</.h3>
            <.h4>h4 Lorem ipsum dolor sit amet, consectet</.h4>
            <.h5>h5 Lorem ipsum dolor sit amet, consectet</.h5>
            <.h6>h6 Lorem ipsum dolor sit amet, consectet</.h6>
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

          <div class="mb-4 space-x-2">
            <%= for size <- ["sm", "md"], type <- ["neutral", "info", "success", "warning", "error"] do %>
              <.badge label={type} size={size} type={type} icon={:keyboard_arrow_down} />
            <% end %>
          </div>
          <div class="mb-4 space-x-2">
            <%= for size <- ["sm", "md"], type <- ["neutral", "info", "success", "warning", "error"] do %>
              <.badge
                label={type}
                size={size}
                type={type}
                icon_position="end"
                icon={:keyboard_arrow_down}
              />
            <% end %>
          </div>
          <div class="mb-4 space-x-2">
            <%= for size <- ["sm", "md"], type <- ["neutral", "info", "success", "warning", "error"] do %>
              <.badge size={size} type={type} icon={:keyboard_arrow_down} />
            <% end %>
          </div>
          <div class="w-fit grid grid-cols-2 gap-4 mb-4">
            <.avatar src="https://i.pravatar.cc/300" />
            <.avatar src="https://i.pravatar.cc/300" shape="square" />
            <.avatar initials="AB" />
            <.avatar initials="AB" shape="square" />
            <.avatar />
            <.avatar shape="square" />
          </div>

          <div class="w-fit grid grid-cols-3 gap-4">
            <%= for  color <- ["primary", "secondary", "neutral", "info", "success", "warning", "error"], variant <-["filled", "outlined", "text"] do %>
              <.button variant={variant} color={color} label={"#{variant}-#{color}"} />
            <% end %>
          </div>

          <div class="p-2 bg-primary-500">
            <.button variant="filled" color="white" label="filled-white" />
            <%= for  variant <-["outlined", "text"] do %>
              <.button variant={variant} color="white" label={"#{variant}-white"} />
            <% end %>
          </div>

          <div>
            <.button label="button" size="sm" href="#" />
            <.button label="button" size="sm" href="/" />
            <.button label="button" size="sm" patch="/" />
            <.button label="button" size="sm" navigate="/" />
          </div>

          <div>
            <.button label="left icon" left_icon={:error} />
            <.button label="right icon" right_icon={:error} />
            <.button label="left and right icons" left_icon={:error} right_icon={:error} />
          </div>

          <div>
            <%= for size <- ["sm", "md", "lg"] do %>
              <.button label={"size: #{size}"} size={size} />
            <% end %>
          </div>

          <div>
            <.button primary label="primary" />
            <.button secondary label="secondary" />
            <.button tertiary label="tertiary" />
          </div>

          <div>
            <.button icon={:error} size="sm" />
            <.button icon={:error} />
            <.button icon={:error} size="lg" />
          </div>
        </div>

        <div>
          <.form :let={f} for={:checkbox}>
            <.checkbox form={f} field={:sm} label="checkbox sm" size="sm" />
            <.checkbox form={f} field={:md} label="checkbox md" />
            <.checkbox form={f} field={:lg} size="lg">
              checkbox lg
            </.checkbox>
          </.form>
        </div>

        <div>
          <.form :let={f} for={:radio_button}>
            <.radio_button form={f} field={:radio} value="sm" label="radio_button sm" size="sm" />
            <.radio_button form={f} field={:radio} value="md" label="radio_button md" />
            <.radio_button form={f} field={:radio} value="lg" size="lg">
              radio_button lg
            </.radio_button>
          </.form>
        </div>

        <div>
          <.form :let={f} for={:switch}>
            <.switch form={f} field={:switch} />
            <.switch form={f} field={:icon} icon={:check} checked />
            <.switch form={f} field={:disabled} disabled />
            <.switch form={f} field={:checked_disabled} checked disabled />
            <.switch form={f} field={:checked_disabled_icon} icon={:close} checked disabled />
          </.form>
        </div>

        <div class="mb-4">
          <.form :let={f} for={:input} multipart class="space-y-4">
            <.form_field form={f} field={:text} label="text" placeholder="text">
              <:secondary_label>
                (Optional) <.icon icon={:info} class="text-[16px] align-middle" />
              </:secondary_label>
            </.form_field>

            <.form_field type="email" form={f} field={:email} label="email" placeholder="email" />

            <.form_field
              type="password"
              form={f}
              field={:password}
              label="password"
              placeholder="password"
            />

            <.form_field
              type="textarea"
              form={f}
              field={:textarea}
              label="textarea"
              placeholder="textarea"
            />

            <.form_field
              type="select"
              form={f}
              field={:select}
              label="select"
              placeholder="select"
              options={[One: :one, Two: :two, Three: :three]}
            />

            <.multiselect
              form={f}
              field={:multiselect}
              label="multiselect"
              options={[One: :one, Two: :two, Three: :three]}
            />

            <.form_field
              type="file"
              form={f}
              field={:file_input}
              label="file_input"
              placeholder="file_input"
            />

            <.form_field type="date_select" form={f} field={:date_select} label="date_select" />

            <.form_field type="date" form={f} field={:date} label="date" />

            <.form_field type="number" form={f} field={:number} label="number_field" />

            <.form_field form={f} field={:success_state} label="success_state" state="success" />

            <.form_field form={f} field={:error_state} label="error_state" state="error" />

            <.form_field form={f} field={:with_error} label="with_error" error_message="Error!" />

            <.form_field form={f} field={:left_icon} label="left_icon" left_icon={:info} />

            <.form_field form={f} field={:right_icon} label="right_icon" right_icon={:info} />
          </.form>
        </div>

        <div class="mb-4 space-y-4">
          <%= for size <- ["sm", "md", "lg"], type <- ["info", "success", "warning", "error"]  do %>
            <.banner
              type={type}
              size={size}
              label="Label"
              message="Lorem ipsum dolor sit amet, consectet"
              close_button_attributes={[]}
            />
          <% end %>
        </div>

        <div class="mb-4">
          <.tag label="TAG" />
          <.tag label="looooooooooooooooooooooooooooong" class="w-20" />
        </div>

        <div>
          <.dropdown_item label="Dropdown item" />
          <.dropdown_item label="Dropdown item selected" selected />
          <.dropdown_item selected check_icon_position="right">
            <div>
              Dropdown item selected
            </div>
          </.dropdown_item>
        </div>

        <div class="flex space-x-4">
          <.icon icon={:info} class="text-[20px] text-primary-200" />
          <.icon icon={:overland_lesson_icon} class="h-8 w-8 text-secondary-200" />
          <.icon icon={:night_lesson_icon} />
          <.icon icon={:highway_lesson_icon} />
        </div>

        <div class="grid gap-4 p-4 grid-cols-3 bg-neutral-900">
          <%= for progress <- [12.0, 23.0, 56.0, 78.0], color <- ["info", "driving", "theory"] do %>
            <.timer text="60:00" progress={progress} color={color} />
          <% end %>
        </div>
      </div>
    </.admin_layout>
    """
  end

  defp side_nav_sections() do
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
  end

  defp breadcrumbs() do
    [
      %{label: "Link", href: "#", icon: :image},
      %{label: "Live patch", patch: "#"},
      %{label: "Live redirect", navigate: "#"},
      %{label: "Active"}
    ]
  end
end
