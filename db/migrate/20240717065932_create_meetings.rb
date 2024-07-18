class CreateMeetings < ActiveRecord::Migration[7.1]
  def change
    create_table :meetings do |t|
      t.string :title
      t.text :description
      t.text :location
      t.datetime :start_time
      t.datetime :end_time
      t.integer :form_id

      t.timestamps
      t.index :form_id
    end
  end
end
