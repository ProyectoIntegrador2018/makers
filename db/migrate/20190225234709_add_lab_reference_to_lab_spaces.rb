class AddLabReferenceToLabSpaces < ActiveRecord::Migration[5.2]
  def change
    add_reference :lab_spaces, :lab, foreign_key: true
  end
end
