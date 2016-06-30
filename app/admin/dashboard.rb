ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        p "Welcome to Lesson Land admin. Please select an item from the menu above to add, remove or modify lessons."
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Lessons" do
          ul do
            Lesson.order("created_at DESC").limit(6).map do |lesson|
              li link_to(lesson.name, admin_lesson_path(lesson))
            end
          end
        end
      end
    end
      #   column do
      #     panel "Info" do
      #       para "Welcome to ActiveAdmin."
      #     end
      #   end
      # end
    end # content
  end
