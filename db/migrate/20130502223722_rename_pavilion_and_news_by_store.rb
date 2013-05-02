class RenamePavilionAndNewsByStore < ActiveRecord::Migration
  def self.up
  	rename_column :stores, :pavilion, :pavilion_url
  	rename_column :stores, :news, :news_url
  end

  def self.down
  	rename_column :stores, :pavilion_url, :pavilion
  	rename_column :stores, :news_url, :news
  end
end
