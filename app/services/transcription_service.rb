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
        languageCode: "en-US"
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
      result["results"].map { |r| r["alternatives"].first["transcript"] }.join(" ")
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
