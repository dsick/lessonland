class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :lesson, null: false, index: true
      t.references :user, null: false, index: true
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.timestamps null: false
    end
  end
end
