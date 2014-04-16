class CreateDailyExpenses < ActiveRecord::Migration
  def change
    create_table :daily_expenses do |t|
      t.integer :store_id
      t.text :expense_for
      t.integer :expense
      t.integer :expense_by
      t.timestamps
    end
  end
end
