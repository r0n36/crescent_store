class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|
      t.integer :report_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.text :address

      t.timestamps
    end
  end
end
