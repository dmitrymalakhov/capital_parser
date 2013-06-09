class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.text :path
      t.references :pavilion
      t.references :store

      t.timestamps
    end
    add_index :regions, :pavilion_id
    add_index :regions, :store_id
  end
end
