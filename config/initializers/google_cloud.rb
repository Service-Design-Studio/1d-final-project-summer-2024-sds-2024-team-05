# config/initializers/google_cloud.rb

require "google/cloud/speech"

# Ensure the GOOGLE_APPLICATION_CREDENTIALS environment variable is set
ENV['GOOGLE_APPLICATION_CREDENTIALS'] = Rails.root.join('config', 'service-account.json').to_s

Google::Cloud::Speech.configure do |config|
  config.credentials = ENV['GOOGLE_APPLICATION_CREDENTIALS']
end

Rails.logger.debug "GOOGLE_APPLICATION_CREDENTIALS: #{ENV['GOOGLE_APPLICATION_CREDENTIALS']}"
