class CreateBrandNames < ActiveRecord::Migration
  def change
    create_table :brand_names do |t|
      t.string :title

      t.timestamps
    end
  end
end
