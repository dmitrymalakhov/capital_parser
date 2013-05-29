class CreateFilmSchedules < ActiveRecord::Migration
  def change
    create_table :film_schedules do |t|
      t.references :store
      t.integer :film_id
      t.string :option
      t.string :auditorium
      t.string :time
      t.integer :price
      t.date :day
      t.timestamps
    end
    add_index :film_schedules, :store_id
  end
end
