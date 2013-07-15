class CreateTypemodes < ActiveRecord::Migration
  def change
    create_table :typemodes do |t|
  	    t.string :title
		t.references :store
     	t.timestamps
    end
  end
end
