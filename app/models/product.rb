class Product < ActiveRecord::Base
  belongs_to :store
  has_many :reports
  has_one :attribute

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
