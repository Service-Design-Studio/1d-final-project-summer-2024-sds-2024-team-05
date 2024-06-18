class AddHospitalToForms < ActiveRecord::Migration[7.1]
  def change
    add_column :forms, :hospital, :boolean
  end
end
