class Category < ActiveRecord::Base
  belongs_to :store
  attr_accessible :title
end
