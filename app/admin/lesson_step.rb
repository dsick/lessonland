ActiveAdmin.register LessonStep do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  form title: 'A custom title' do |f|
    inputs 'Details' do
      input :lesson
      input :sort_order
      input :photo, as: :file
      input :title
      input :description
    end
    para "Press cancel to return to the list without saving."
    actions
  end

  show do
    attributes_table do
      row :lesson
      row "Image" do |lessonstep |
        image_tag lessonstep.photo_url
      end
      row :title
      row :sort_order
      row :description
    end
    active_admin_comments
  end


  permit_params :lesson_id, :sort_order, :title, :description, :photo
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
