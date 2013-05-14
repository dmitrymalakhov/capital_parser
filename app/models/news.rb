class News < ActiveRecord::Base
  belongs_to :store
  attr_accessible :date_publication, :title
end
