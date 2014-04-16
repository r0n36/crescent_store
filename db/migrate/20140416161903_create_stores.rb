class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.text :location
      t.timestamps
    end
  end
end
