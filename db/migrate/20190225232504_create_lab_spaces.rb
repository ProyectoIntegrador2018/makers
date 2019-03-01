class CreateLabSpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_spaces do |t|
      t.string :name
      t.text :description
      t.string :hours
      t.string :location
      t.string :contact_email
      t.string :contact_phone

      t.timestamps
    end
  end
end
