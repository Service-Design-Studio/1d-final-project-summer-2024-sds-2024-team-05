class Form < ApplicationRecord
    # include Rails.application.routes.url_helpers
    attr_accessor :others_text, :autofill_address, :admin
    has_one_attached :discharge_summary
    has_one_attached :physical_video
    has_one_attached :mental_video
    has_one_attached :environment_video
    has_one_attached :service_agreement_form
    belongs_to :user
    has_one :meeting, dependent: :destroy

    before_save :update_last_edit

    # def full_name
    #     "#{self.first_name} #{self.last_name}"
    # end

    def transfer_to_new_user(email_attribute)
        new_user = User.find_by(email: self[email_attribute])

        if new_user
          self.user = new_user  # Update the user association of the form
          save  # Save the form with the updated user association

          if user == new_user
            puts'Form transferred to new user successfully.'
            return true
          else
            puts 'Failed to transfer form to new user.'
            return false
          end
        else
          puts 'User with specified email address not found.'
          return false
        end
      end

    def update_last_edit
        unless changed_attributes.except('last_edit', 'last_viewed').empty?
            if !admin
                self.last_edit = DateTime.now
            end
        end
    end

    def update_last_viewed
        self.last_viewed = DateTime.now
        save
    end

    def unseen_changes
        if self.last_viewed.nil?
            true
        else
            self.last_edit > self.last_viewed
        end
    end

    def all_required
        return ['edit_1_valid', 'edit_2_valid', 'edit_3_valid', 'mental_uploaded', 'physical_uploaded', 'environment_uploaded']
    end

    def page1_required
       return ['date_of_birth', 'nok_address', 'nok_email', 'nok_contact_no', 'nok_first_name', 'nok_last_name', 'first_name', 'last_name', 'gender', 'address', 'relationship', 'languages', 'postal']
    end

    def pg1_valid
        page1_required.all? { |key| self.send(key).present? }
    end

    def page2_required
        return ['height', 'weight', 'conditions', 'medication', 'hospital']
    end

    def pg2_valid
        page2_required.all? { |key| !self.send(key).to_s.empty?}
    end

    def page3_required
        return ['services', 'start_date', 'end_date']
     end

    def pg3_valid
        page3_required.all? { |key| self.send(key).present? }
    end

    def pg4_valid
        physical_video.attached? && mental_video.attached?
    end

    def pg5_valid
        environment_video.attached?
    end

    def submittable
        pg1_valid && pg2_valid && pg3_valid && pg4_valid && pg5_valid
    end


    def transcribe_video_and_update_form
        video = self.mental_video
        audio_path = Rails.root.join('tmp', "mental_audio.wav")

        begin
          Rails.logger.debug "Extracting audio from #{video.filename} to #{audio_path}"
          video_path = TranscriptionService.download_video(video.blob) # Download the video to a local path
          TranscriptionService.extract_audio(video_path, audio_path.to_s)

          Rails.logger.debug "Transcribing audio from #{audio_path}"
          transcription = TranscriptionService.transcribe_local_audio(audio_path.to_s)

          Rails.logger.debug "Transcription result: #{transcription}"
          self.update(mental_transcription: transcription)
          Rails.logger.debug "Updated mental_transcription: #{self.mental_transcription}"
        rescue => e
          Rails.logger.error "Failed to transcribe mental video: #{e.message}"
        ensure
          Rails.logger.debug "Deleting temporary audio file #{audio_path}"
          File.delete(audio_path) if File.exist?(audio_path)
        end
    end


    # before_save do
    #     self.languages.gsub!(/[\[\]\"]/,"") if attribute_present?("languages")
    #     self.conditions.gsub!(/[\[\]\"]/,"") if attribute_present?("conditions")
    #     self.services.gsub!(/[\[\]\"]/,"") if attribute_present?("services")
    # end

end
