class FilmSchedule < ActiveRecord::Base
  belongs_to :store
  attr_accessible :day, :month, :year, :auditorium, :film_id, :option, :price, :time
end
