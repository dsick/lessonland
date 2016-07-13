class RenameCategoriesToCategoryOnLesson < ActiveRecord::Migration
  def change
    rename_column :lessons, :categories_id, :category_id
  end
end
