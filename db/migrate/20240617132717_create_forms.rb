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
      t.string :languages
      t.text :languages_other
      t.text :mental_primary_assessment
      t.text :physical_primary_assessment
      t.text :environment_primary_assessment
      t.text :mental_assessment
      t.text :physical_assessment
      t.text :environment_assessment
      t.datetime :meet_date
      t.string :nok_address
      t.string :nok_contact_no
      t.string :nok_first_name
      t.string :nok_last_name
      t.string :nok_email
      t.boolean :submitted
      t.datetime :last_edit
      t.datetime :last_viewed
      t.timestamps
    end
  end
end
