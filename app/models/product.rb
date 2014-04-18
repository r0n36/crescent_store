require 'file_size_validator'
class Product < ActiveRecord::Base
  belongs_to :store
  has_many :reports
  has_one :attribute

  mount_uploader :image, ImageUploader
  validates :image,
            :file_size => { :maximum => 0.5.megabytes.to_i}

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
