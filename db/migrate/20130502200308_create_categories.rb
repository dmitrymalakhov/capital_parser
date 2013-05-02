class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.references :store

      t.timestamps
    end
    add_index :categories, :store_id
  end
end
