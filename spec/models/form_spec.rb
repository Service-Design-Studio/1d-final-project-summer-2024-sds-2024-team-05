require 'rails_helper'

RSpec.describe Form, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:form) { FactoryBot.create(:form, user: user) }

    it 'is valid with valid attributes' do
      form = FactoryBot.build(:form)
      expect(form).to be_valid
    end

    it 'is invalid with invalid attributes' do
      form = FactoryBot.build(:form, first_name: "")
      expect(form.pg1_valid).to be_falsey
    end

    describe 'update_last_edit' do
    it 'updates last_edit if there are changes' do
      form.first_name = 'NewName'
      expect { form.save }.to change { form.last_edit }
    end

    it 'does not update last_edit if there are no param changes' do
      expect { form.save }.not_to change { form.last_edit }
    end

    it 'updates name if there are changes to name' do
      form = FactoryBot.build(:form)
      form.update(first_name: 'jane')
      expect(form.first_name).to eq('jane')
    end
  end

  describe 'submittable' do
  #   it 'returns true if all pages are valid' do
  #     expect(form.submittable).to be_truthy
  #   end

    it 'returns false if there is user but it is the same user' do
      expect(form.transfer_to_new_user(user.email)).to be_falsey
    end

    it 'returns true if there is user but it is the same user' do
      expect(form.transfer_to_new_user(user.email)).to be_falsey
    end

    it 'returns false if page 3 is not valid' do
      form.start_date = nil
      expect(form.submittable).to be_falsey
    end
  end

  describe 'Transfer to new user method' do
    #   it 'returns true if all pages are valid' do
    #     expect(form.submittable).to be_truthy
    #   end
  
      it 'returns false if page 1 is not valid' do
        form.first_name = ''
        expect(form.submittable).to be_falsey
      end
  
      it 'returns false if page 2 is not valid' do
        form.height = nil
        expect(form.submittable).to be_falsey
      end
  
      it 'returns false if page 3 is not valid' do
        form.start_date = nil
        expect(form.submittable).to be_falsey
      end
    end

  describe '#transcribe_video_and_update_form' do
  let(:form) { create(:form) }
  let(:filename) { 'test_video.mp4' }
  let(:gcs_service) { instance_double(GoogleCloudStorageService) }
  let(:transcription_service) { class_double(TranscriptionService) }
  let(:audio_path) { Rails.root.join('tmp', "mental_audio.wav").to_s }
  let(:video_path) { Rails.root.join('tmp', "mental_video.mp4").to_s }
  let(:transcription) { 'This is a sample transcription.' }

  before do
    allow(GoogleCloudStorageService).to receive(:new).and_return(gcs_service)
    allow(gcs_service).to receive(:download_file)
    allow(TranscriptionService).to receive(:delete_mental_video)
    allow(TranscriptionService).to receive(:extract_audio)
    allow(TranscriptionService).to receive(:transcribe_local_audio).and_return(transcription)
  end
    it 'downloads the video, extracts audio, transcribes it, updates the form, and deletes temporary files' do
      expect(gcs_service).to receive(:download_file).with(filename, video_path)
      expect(TranscriptionService).to receive(:extract_audio).with(video_path, audio_path)
      expect(TranscriptionService).to receive(:transcribe_local_audio).with(audio_path)

      form.transcribe_video_and_update_form(filename)

      expect(form.mental_transcription).to eq(transcription)
    end

    it 'logs an error if an exception occurs' do
      allow(gcs_service).to receive(:download_file).and_raise(StandardError.new('Download failed'))

      expect(Rails.logger).to receive(:error).with("Failed to transcribe mental video: Download failed")

      form.transcribe_video_and_update_form(filename)
    end
  end


  describe '#update_animal_count' do
  let(:form) { create(:form, mental_transcription: 'Cow, pig') }
  let(:count) { 2 }
  
  before do
    allow(TranscriptionService).to receive(:count_unique_animals).and_return(count)
  end
    context 'when mental_transcription is present' do
      it 'updates the animal count' do
        expect(TranscriptionService).to receive(:count_unique_animals).with(form.mental_transcription)
        expect(form).to receive(:update).with(animal_count: count)

        form.update_animal_count
      end
    end

    context 'when an exception occurs' do
      it 'logs an error' do
        allow(TranscriptionService).to receive(:count_unique_animals).and_raise(StandardError.new('Counting failed'))

        form.update_animal_count
      end
    end
  end
end