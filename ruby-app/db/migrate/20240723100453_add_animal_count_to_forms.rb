class AddAnimalCountToForms < ActiveRecord::Migration[7.1]
  def change
    add_column :forms, :animal_count, :integer
  end
end
