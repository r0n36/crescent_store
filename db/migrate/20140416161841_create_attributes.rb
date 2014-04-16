class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.integer :product_id
      t.string :color
      t.string :category
      t.string :size
      t.integer :price
      t.timestamps
    end
  end
end
