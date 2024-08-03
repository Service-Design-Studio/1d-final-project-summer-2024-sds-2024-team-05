class AddDetailsToForms < ActiveRecord::Migration[7.1]
  def change
    add_column :forms, :physical_assessment_detail, :text
    add_column :forms, :mental_assessment_detail, :text
    add_column :forms, :environment_assessment_detail, :text
  end
end
