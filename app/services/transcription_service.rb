class TranscriptionService
  GOOGLE_SPEECH_API_URL = "https://speech.googleapis.com/v1/speech:recognize?key=AIzaSyBl27-QCygSSfy2izoe-coi9pqgDs89piI"

  def self.transcribe_local_audio(file_path)
    raise "Audio file does not exist: #{file_path}" unless File.exist?(file_path)

    uri = URI.parse(GOOGLE_SPEECH_API_URL)
    audio_content = File.binread(file_path)
    base64_audio = Base64.urlsafe_encode64(audio_content)

    request_body = {
      config: {
        encoding: "LINEAR16",
        sampleRateHertz: 16000,
        languageCode: "en-US",
        diarizationConfig: {
          enableSpeakerDiarization: true,
          minSpeakerCount: 2,
          maxSpeakerCount: 2
        },
        use_enhanced: true,
        model:"medical",
        enable_automatic_punctuation: true,
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

      # Collect words with their speaker tags
      words_with_speaker = []

      result["results"].each do |result|
        result["alternatives"].each do |alternative|
          alternative["words"].each do |word_info|
            words_with_speaker << { word: word_info["word"], speaker: word_info["speakerTag"] }
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
          formatted_transcript += "#{current_sentence.strip}\n" unless current_sentence.strip.empty?
          current_sentence = "#{role}: #{word}"
          current_speaker = speaker_tag
        else
          current_sentence += " #{word}"
        end

        # End the sentence if punctuation is encountered
        if word.match?(/[.!?]/)
          formatted_transcript += "#{current_sentence.strip}\n"
          current_sentence = ""
          current_speaker = nil
        end
      end

      # Append any remaining sentence
      formatted_transcript += "#{current_sentence.strip}\n" unless current_sentence.strip.empty?

      # Remove any leading/trailing whitespace and return the formatted transcript
      formatted_transcript.strip
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
    ffmpeg_command = "ffmpeg -y -i \"#{video_path}\" -ac 1 -ar 16000 -f wav \"#{audio_path}\""
    system(ffmpeg_command)
    Rails.logger.debug "FFmpeg Command: #{ffmpeg_command}"
    raise "Audio extraction failed" unless File.exist?(audio_path)
    Rails.logger.debug "Audio file exists: #{File.exist?(audio_path)}"
  end
end
