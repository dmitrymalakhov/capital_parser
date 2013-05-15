class NewsGallery < ActiveRecord::Base
  belongs_to :news
  attr_accessible :image
end
