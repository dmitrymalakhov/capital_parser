class AddPathToTypemodes < ActiveRecord::Migration
  def change
    add_column :typemodes, :path, :string, :default => ""
  end
end
