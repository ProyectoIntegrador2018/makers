class AddNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :given_name, :string, null: false
    add_column :users, :last_name, :string, null: false
  end
end
