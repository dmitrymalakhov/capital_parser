class CreatePavilions < ActiveRecord::Migration
  def change
    create_table :pavilions do |t|
      t.references :category
      t.references :brand_name

      t.timestamps
    end
    add_index :pavilions, :category_id
    add_index :pavilions, :brand_name_id
  end
end
