class AddImageToLabSpaces < ActiveRecord::Migration[5.2]
  def change
    add_column :lab_spaces, :image, :string
  end
end
