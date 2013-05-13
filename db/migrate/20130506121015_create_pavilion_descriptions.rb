class CreatePavilionDescriptions < ActiveRecord::Migration
  def change
    create_table :pavilion_descriptions do |t|
      t.string :logo
      t.text :content
      t.integer :floor
      t.string :site
      t.string :phone
      t.references :pavilion
      t.timestamps
    end
      add_index :pavilion_descriptions, :pavilion_id
  end
end
