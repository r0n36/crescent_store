class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :consumer_id
      t.integer :seller_id
      t.integer :product_id
      t.integer :store_id
      t.integer :quantity
      t.timestamps
    end
  end
end
