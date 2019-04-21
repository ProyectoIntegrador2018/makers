class CreateLabAdministrations < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_administrations do |t|
      t.references :admin, index: true, foreign_key: { to_table: :users }
      t.references :space, polymorphic: true, index: true
      t.timestamps
    end
  end
end
