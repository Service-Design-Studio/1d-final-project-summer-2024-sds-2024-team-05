# Load the Rails application.
require_relative "application"

# Load the app's custom environment variables here, so that they are loaded before environments/*.rb
app_environment_variables = File.join(Rails.root, 'config', 'app_environment_variables.rb')
load(app_environment_variables) if File.exist?(app_environment_variables)

# Decode the base64 string and write it to a temporary file
if ENV['GOOGLE_APPLICATION_CREDENTIALS_BASE64']
  require 'tempfile'
  json_tempfile = Tempfile.new('service_account')
  json_tempfile.write(Base64.decode64(ENV['GOOGLE_APPLICATION_CREDENTIALS_BASE64']))
  json_tempfile.rewind
  ENV['GOOGLE_APPLICATION_CREDENTIALS'] = json_tempfile.path
end

# Initialize the Rails application.
Rails.application.initialize!
