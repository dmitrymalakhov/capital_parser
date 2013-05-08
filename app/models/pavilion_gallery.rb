class PavilionGallery < ActiveRecord::Base
  belongs_to :pavilion
  attr_accessible :image
end
