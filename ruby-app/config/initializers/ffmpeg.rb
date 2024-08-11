# config/initializers/ffmpeg.rb

ffmpeg_path = Rails.root.join('vendor', 'ffmpeg', 'bin', 'ffmpeg.exe').to_s
ffprobe_path = Rails.root.join('vendor', 'ffmpeg', 'bin', 'ffprobe.exe').to_s

FFMPEG.ffmpeg_binary = ffmpeg_path
FFMPEG.ffprobe_binary = ffprobe_path
