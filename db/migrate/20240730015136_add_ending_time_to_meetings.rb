class AddEndingTimeToMeetings < ActiveRecord::Migration[7.1]
  def change
    add_column :meetings, :ending_time, :datetime
  end
end
