class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :title
      t.string :base_url
      t.string :pavilion_url
      t.string :services_url
      t.string :news_url

      t.timestamps
    end
  end
end
