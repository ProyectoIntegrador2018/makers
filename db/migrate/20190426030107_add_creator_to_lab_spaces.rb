class AddCreatorToLabSpaces < ActiveRecord::Migration[5.2]
  def change
    add_reference :lab_spaces, :creator, foreign_key: { to_table: :users }, index: true
  end
end
