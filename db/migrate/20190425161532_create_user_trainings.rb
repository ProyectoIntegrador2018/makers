class CreateUserTrainings < ActiveRecord::Migration[5.2]
  def change
    create_table :user_trainings do |t|
      t.references :training, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
