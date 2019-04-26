class AddCreatorToLabs < ActiveRecord::Migration[5.2]
  def change
    add_reference :labs, :creator, foreign_key: { to_table: :users }, index: true
  end
end
