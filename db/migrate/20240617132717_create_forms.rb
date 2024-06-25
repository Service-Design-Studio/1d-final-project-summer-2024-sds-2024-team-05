class CreateForms < ActiveRecord::Migration[7.1]
  def change
    create_table :forms do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :date_of_birth
      t.string :address
      t.string :relationship
      t.string :hobbies
      t.integer :height
      t.integer :weight
      t.string :conditions
      t.text :conditions_other
      t.string :medication
      t.boolean :hospital
      t.string :services
      t.text :services_other
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
