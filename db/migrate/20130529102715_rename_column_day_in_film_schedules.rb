class RenameColumnDayInFilmSchedules < ActiveRecord::Migration
def change
    change_table :film_schedules do |t|
      t.rename :day, :date
    end
  end
end
