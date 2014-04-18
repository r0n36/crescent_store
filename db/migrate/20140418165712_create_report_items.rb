class CreateReportItems < ActiveRecord::Migration
  def change
    create_table :report_items do |t|
      t.references :product, index: true
      t.belongs_to :report, index: true
      t.integer :quantity
      t.timestamps
    end
  end
end
