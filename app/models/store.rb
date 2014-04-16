class Store < ActiveRecord::Base
  has_many :products
  has_many :users
  has_many :daily_expenses
end
