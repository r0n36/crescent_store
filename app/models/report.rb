class Report < ActiveRecord::Base
  belongs_to :product
  has_one :consumer
end
