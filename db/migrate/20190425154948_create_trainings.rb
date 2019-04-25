class CreateTrainings < ActiveRecord::Migration[5.2]
  def change
    create_table :trainings do |t|
      t.string :name
      t.text :description
      t.references :equipment, foreign_key: true

      t.timestamps
    end
  end
end
