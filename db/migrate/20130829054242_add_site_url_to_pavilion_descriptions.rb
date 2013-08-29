class AddSiteUrlToPavilionDescriptions < ActiveRecord::Migration
  def change
    add_column :pavilion_descriptions, :site_url, :string
  end
end
