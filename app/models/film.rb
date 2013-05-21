class Film < ActiveRecord::Base
  attr_accessible :poster, :actors, :content, :duration, :engtitle, :genre, :in_theaters, :producer, :production, :title
end
