class CreatePavilionDescriptions < ActiveRecord::Migration
  def change
    create_table :pavilion_descriptions do |t|
      t.string :logo
      t.text :content
      t.string :floor
      t.string :site
      t.references :pavilion
      t.timestamps
    end
      add_index :pavilion_descriptions, :pavilion_id
  end
end
