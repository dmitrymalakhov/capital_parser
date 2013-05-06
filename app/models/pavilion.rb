class Pavilion < ActiveRecord::Base
  belongs_to :category
  belongs_to :brand_name

  accepts_nested_attributes_for :brand_name
end
