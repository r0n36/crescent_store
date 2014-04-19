module ReportsHelper
  def calculate_total_price(report)
    total_price = 0
    report.report_items.each do |item|
      product = Product.find item.product_id
      total_price += product.attribute.price
    end

    return (total_price + (total_price * 0.15))
  end
  def calculate_total_quantity(report)
    total_quantity = 0
    report.report_items.each do |item|
      total_quantity += item.quantity
    end
    return total_quantity
  end
end
