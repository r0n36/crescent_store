class Report < ActiveRecord::Base
  belongs_to :product
  belongs_to :store
  has_one :consumer
  has_many :report_items

  def add_product(product_id)
    current_item = report_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = report_items.build(product_id: product_id)
      #current_item.price = current_item.product.attribute.price
    end
    current_item
  end

end
