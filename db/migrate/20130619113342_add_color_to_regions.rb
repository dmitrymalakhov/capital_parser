class AddColorToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :color, :string
  end
end
