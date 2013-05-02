class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :title
      t.string :base_url
      t.string :pavilion
      t.string :news

      t.timestamps
    end
  end
end
