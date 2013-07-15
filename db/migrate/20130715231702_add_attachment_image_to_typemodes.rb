class AddAttachmentImageToTypemodes < ActiveRecord::Migration
  def self.up
    change_table :typemodes do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :typemodes, :image
  end
end
