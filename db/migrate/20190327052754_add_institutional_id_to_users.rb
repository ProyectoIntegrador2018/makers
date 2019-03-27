class AddInstitutionalIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :institutional_id, :string
  end
end
