class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :image
      t.string :name
      t.string :percentage

      t.timestamps
    end
  end
end
