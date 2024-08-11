class AddMentalTranscriptionToForms < ActiveRecord::Migration[7.1]
  def change
    add_column :forms, :mental_transcription, :text
  end
end
