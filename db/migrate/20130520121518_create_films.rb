class CreateFilms < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.string :title
      t.string :engtitle
      t.string :genre
      t.string :duration
      t.string :in_theaters
      t.string :production
      t.string :producer
      t.string :actors
      t.text :content

      t.timestamps
    end
  end
end
