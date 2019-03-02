class AddImageToLabs < ActiveRecord::Migration[5.2]
  def change
    add_column :labs, :image, :string
  end
end
