class Film < ActiveRecord::Base
  attr_accessible :actors, :content, :duration, :engtitle, :genre, :in_theaters, :producer, :production, :title
end
