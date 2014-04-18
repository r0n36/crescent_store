class Store < ActiveRecord::Base
  has_many :products
  has_many :users
  has_many :daily_expenses
  has_many :reports
end
