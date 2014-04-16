class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :store_id
      t.string :code
      t.integer :quantity
      t.timestamps
    end
  end
end
