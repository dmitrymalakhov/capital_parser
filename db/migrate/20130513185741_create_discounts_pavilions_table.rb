class CreateDiscountsPavilionsTable < ActiveRecord::Migration
 def self.up
    create_table :discounts_pavilions, :id => false do |t|
        t.references :discount
        t.references :pavilion
    end
    add_index :discounts_pavilions, [:discount_id, :pavilion_id]
    add_index :discounts_pavilions, [:pavilion_id, :discount_id]
  end

  def self.down
    drop_table :discounts_pavilions
  end
end
