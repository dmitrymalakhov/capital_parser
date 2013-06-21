class AddTitleboxToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :titlebox, :string
  end
end
