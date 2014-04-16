class Product < ActiveRecord::Base
  belongs_to :store
  has_many :reports
  has_one :attribute
end
