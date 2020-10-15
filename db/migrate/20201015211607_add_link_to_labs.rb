class AddLinkToLabs < ActiveRecord::Migration[5.2]
  def change
    add_column :labs, :location_link, :string
  end
end
