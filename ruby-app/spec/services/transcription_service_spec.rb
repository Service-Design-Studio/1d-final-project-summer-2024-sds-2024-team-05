require 'streamio-ffmpeg'

RSpec.describe TranscriptionService, type: :service do
  describe 'count_unique_animals' do
    it 'counts unique animals in the transcription' do
      transcription = "The cow jumped over the moon. The cat and the dog followed."
      result = TranscriptionService.count_unique_animals(transcription)
      expect(result).to eq 3
    end

    it 'ignores case and repeated animals' do
      transcription = "The Cow and the cow and the Dog."
      result = TranscriptionService.count_unique_animals(transcription)
      expect(result).to eq 2
    end

    it 'ignores male and female words' do
      transcription = "The male lion and female lioness."
      result = TranscriptionService.count_unique_animals(transcription)
      expect(result).to eq 1
    end
  end
end