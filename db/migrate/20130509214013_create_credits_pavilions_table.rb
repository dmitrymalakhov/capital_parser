class CreateCreditsPavilionsTable < ActiveRecord::Migration
  def self.up
    create_table :credits_pavilions, :id => false do |t|
        t.references :credit
        t.references :pavilion
    end
    add_index :credits_pavilions, [:credit_id, :pavilion_id]
    add_index :credits_pavilions, [:pavilion_id, :credit_id]
  end

  def self.down
    drop_table :credits_pavilions
  end
end