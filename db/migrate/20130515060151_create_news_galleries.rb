class CreateNewsGalleries < ActiveRecord::Migration
  def change
    create_table :news_galleries do |t|
      t.string :image
      t.references :news

      t.timestamps
    end
    add_index :news_galleries, :news_id
  end
end
