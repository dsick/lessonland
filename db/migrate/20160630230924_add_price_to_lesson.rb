class AddPriceToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :price, :decimal, precision: 8, scale: 2
  end
end
