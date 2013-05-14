class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :date_publication
      t.references :store

      t.timestamps
    end
    add_index :news, :store_id
  end
end
