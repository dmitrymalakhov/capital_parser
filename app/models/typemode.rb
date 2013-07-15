class Typemode < ActiveRecord::Base
	belongs_to :store
 	attr_accessible :title, :image, :store_id
 	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
