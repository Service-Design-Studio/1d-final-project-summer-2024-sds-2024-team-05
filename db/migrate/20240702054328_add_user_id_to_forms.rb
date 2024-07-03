class AddUserIdToForms < ActiveRecord::Migration[7.1]
  def change
    add_column :forms, :user_id, :integer
    add_index :forms, :user_id
  end
end
