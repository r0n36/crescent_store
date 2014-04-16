module ProductsHelper
  def product_categories
    products = ["Shoe","Moneybag","Handbag"]
  end
  def store_locations
    stores = []
    Store.all.each do |store|
      stores << store.location
    end
    return stores
  end
end
