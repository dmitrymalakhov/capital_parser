class News < ActiveRecord::Base
  belongs_to :store
  has_many :news_gallery
  attr_accessible :date_publication, :title, :content
end
