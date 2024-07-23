require 'streamio-ffmpeg'

class TranscriptionService
  GOOGLE_SPEECH_API_URL = "https://speech.googleapis.com/v1/speech:recognize?key=AIzaSyBl27-QCygSSfy2izoe-coi9pqgDs89piI"

  def self.transcribe_local_audio(file_path)
    raise "Audio file does not exist: #{file_path}" unless File.exist?(file_path)

    uri = URI.parse(GOOGLE_SPEECH_API_URL)
    audio_content = File.binread(file_path)
    base64_audio = Base64.strict_encode64(audio_content)

    request_body = {
      config: {
        encoding: "LINEAR16",
        sampleRateHertz: 16000,
        languageCode: "en-US",
        diarizationConfig: {
          enableSpeakerDiarization: true,
          minSpeakerCount: 2,
          maxSpeakerCount: 2
        }
      },
      audio: {
        content: base64_audio
      }
    }.to_json

    response = Net::HTTP.post(uri, request_body, "Content-Type" => "application/json")
    result = JSON.parse(response.body)

    Rails.logger.debug "Transcription API response: #{result.inspect}"

    if result["results"].nil? || result["results"].empty?
      Rails.logger.error "No transcription results returned"
      ""
    else
      Rails.logger.info "Transcription results: #{result['results'].inspect}"

      # Collect words with their speaker tags, filtering out words without speaker tags
      words_with_speaker = result["results"].flat_map do |res|
        res["alternatives"].flat_map do |alternative|
          alternative["words"].select { |word_info| word_info.key?("speakerTag") }.map do |word_info|
            { word: word_info["word"], speaker: word_info["speakerTag"] }
          end
        end
      end

      # Generate the final transcript
      formatted_transcript = ""
      current_speaker = nil
      current_sentence = ""

      words_with_speaker.each do |word_info|
        speaker_tag = word_info[:speaker]
        word = word_info[:word]
        role = speaker_tag == 1 ? "Patient" : "NOK"

        if current_speaker != speaker_tag
          # Finish the current sentence if changing speaker
          formatted_transcript += "#{current_sentence.strip}<br>" unless current_sentence.strip.empty?
          current_sentence = "#{role}: #{word}"
          current_speaker = speaker_tag
        else
          current_sentence += " #{word}"
        end

        # End the sentence if punctuation is encountered
        if word.match?(/[.!?]/)
          formatted_transcript += "#{current_sentence.strip}<br>"
          current_sentence = ""
          current_speaker = nil
        end
      end

      # Append any remaining sentence
      formatted_transcript += "#{current_sentence.strip}<br>" unless current_sentence.strip.empty?

      # Remove any leading/trailing whitespace and return the formatted transcript
      return formatted_transcript.strip
    end
  rescue => e
    Rails.logger.error "Transcription failed: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    raise
  end

  def self.download_video(blob)
    local_video_path = Rails.root.join('tmp', "#{blob.filename}")
    File.open(local_video_path, 'wb') do |file|
      file.write(blob.download)
    end
    local_video_path
  end

  def self.extract_audio(video_path, audio_path)
    video_path = video_path.to_s # Ensure it's a string
    audio_path = audio_path.to_s # Ensure it's a string

    movie = FFMPEG::Movie.new(video_path)
    options = { audio_codec: "pcm_s16le", audio_bitrate: 16000, audio_channels: 1, audio_sample_rate: 16000 }
    movie.transcode(audio_path, options)

    Rails.logger.debug "Audio file exists: #{File.exist?(audio_path)}"
    raise "Audio extraction failed" unless File.exist?(audio_path)
  end

  ANIMALS = {
    'Alligator' => %w[Bull Cow Hatchling],
    'Alpaca' => %w[Male Female Cria],
    'Antelope' => %w[Buck Doe Calf],
    'Armadillo' => %w[Male Female Pup],
    'Baboon' => %w[Male Female Infant],
    'Bear' => %w[Boar Sow Cub],
    'Beaver' => ['Male', 'Female', 'Kit', 'Pup', 'Kitten'],
    'Bee' => %w[Drone Worker Queen Larva],
    'Buffalo' => %w[Bull Cow Calf],
    'Bison' => %w[Bull Cow Calf],
    'Butterfly' => %w[Male Female Chrysalis Larva],
    'Camel' => %w[Bull Cow Calf],
    'Cat' => %w[Tom Queen Kitten],
    'Cattle' => %w[Bull Cow Calf],
    'Cheetah' => %w[Male Female Cub],
    'Chicken' => %w[Rooster Hen Chick Pullet Cockrell],
    'Cicada' => %w[Male Female Nymph],
    'Coyote' => %w[Dog Bitch Pup Whelp],
    'Deer' => %w[Buck Doe Fawn],
    'Dog' => %w[Dog Bitch Pup Puppy],
    'Dolphin' => %w[Bull Cow Calf],
    'Donkey' => %w[Jack Jenny Foal Filly],
    'Dove' => %w[Cock Hen Squab Chick],
    'Duck' => %w[Drake Duck Duckling],
    'Eagle' => %w[Tiercel Hen Eaglet],
    'Echidna' => %w[Male Female Puggle],
    'Elephant' => %w[Bull Cow Calf],
    'Ferret' => %w[Hob Jill Kit],
    'Finch' => %w[Cock Hen Chick Pullet Cockrell],
    'Fish' => %w[Male Female Fingerling Fry],
    'Flamingo' => %w[Male Female Chick],
    'Fox' => %w[Renyard Dog Vixen Cub],
    'Frog' => %w[Male Female Tadpole Polliwog Froglet],
    'Giant Panda' => %w[Boar Sow Cub],
    'Giraffe' => %w[Bull Doe Calf],
    'Goat' => %w[Billy Doe Kid],
    'Goose' => %w[Gander Goose Gosling],
    'Grasshopper' => %w[Male Female Nymph],
    'Grouse' => %w[Blackcock Hen Poult],
    'Guinea Pig' => %w[Boar Sow Pup],
    'Hamster' => %w[Buck Doe Pup],
    'Hare' => %w[Buck Doe Leveret],
    'Hedgehog' => %w[Boar Sow Piglet Pup],
    'Hermit Crab' => %w[Male Female Zoea],
    'Hippopotamus' => %w[Bull Cow Calf],
    'Horse' => %w[Stallion Mare Foal Filly],
    'Human' => %w[Man Woman Baby Infant],
    'Hyena' => %w[Male Female Cub],
    'Ibex' => %w[Buck Doe Kid],
    'Jaguar' => %w[Male Female Cub],
    'Jellyfish' => %w[Boar Sow Ephyna],
    'Kangaroo' => %w[Buck Jack Doe Jill Joey],
    'Koala' => %w[Male Female Joey],
    'Lemur' => %w[Male Princess Pup],
    'Leopard' => %w[Leopard Leopardess Cub],
    'Lion' => %w[Lion Lioness Cub],
    'Llama' => %w[Male Female Cria],
    'Louse' => %w[Male Female Nymph],
    'Lynx' => %w[Male Female Kit],
    'Mole' => %w[Male Female Pup],
    'Mouse' => %w[Buck Doe Pinkie Pup],
    'Opossum' => %w[Jack Jill Joey],
    'Otter' => %w[Male Female Whelp],
    'Owl' => %w[Owl Hen Owlet],
    'Oyster' => %w[- - Spat],
    'Peafowl' => %w[Peacock Peahen Chick],
    'Penguin' => %w[Male Female Chick Nestling],
    'Platypus' => %w[Male Female Platypup Puggle],
    'Polar Bear' => %w[Boar Sow Cub],
    'Rabbit' => %w[Buck Doe Bunny Kit],
    'Raccoon' => %w[Boar Sow Cub],
    'Rhinoceros' => %w[Bull Cow Calf],
    'Sheep' => %w[Ram Ewe Lamb],
    'Skunk' => %w[Boar Sow Kit],
    'Sloth' => %w[Male Female Baby Pup Kitten],
    'Snake' => %w[Male Female Snakelet],
    'Spider' => %w[Male Female Spiderling],
    'Stork' => %w[Male Female Squab Pullet],
    'Swan' => %w[Cob Pen Cygnet Flapper],
    'Swine' => %w[Boar Sow Piglet Shoat],
    'Tiger' => %w[Tiger Tigress Cub],
    'Toad' => %w[Male Female Tadpole],
    'Turkey' => %w[Gobbler Tom Hen Poult],
    'Turtle' => %w[Male Female Hatchling],
    'Walrus' => %w[Bull Cow Cub Pup],
    'Weasel' => %w[Hob Dog Buck Jack Bitch Doe Jill Kit],
    'Whale' => %w[Bull Sow Calf],
    'Wolf' => %w[Dog Bitch Pup],
    'Wombat' => %w[Jack Jill Joey],
    'Zebra' => %w[Stallion Mare Foal]
  }

  def self.count_unique_animals(mental_transcription)
    unique_animals = Set.new
    transcription_words = mental_transcription.downcase.split(/[^\w']+/)  # Convert transcription to lowercase

    transcription_words.each do |word|
      next if %w[male female].include?(word) # Skip the words "male" and "female"

      ANIMALS.each do |animal, stages|
        if stages.map(&:downcase).include?(word) || animal.downcase == word
          unique_animals.add(word)
        end
      end
    end

    unique_animals.size
  end

end
