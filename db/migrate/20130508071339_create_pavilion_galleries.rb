class CreatePavilionGalleries < ActiveRecord::Migration
  def change
    create_table :pavilion_galleries do |t|
      t.string :image
      t.references :pavilion

      t.timestamps
    end
    add_index :pavilion_galleries, :pavilion_id
  end
end
