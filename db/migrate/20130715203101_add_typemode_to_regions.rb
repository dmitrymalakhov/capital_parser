class AddTypemodeToRegions < ActiveRecord::Migration
  def change
  	 add_column :regions, :typemode, :integer, :default => 0
  end
end
