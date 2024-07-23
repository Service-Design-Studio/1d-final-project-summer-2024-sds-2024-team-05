class AddPostalAndNokPostalToForms < ActiveRecord::Migration[7.1]
  def change
    add_column :forms, :postal, :string
    add_column :forms, :nok_postal, :string
  end
end
