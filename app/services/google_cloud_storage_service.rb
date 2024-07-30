require "google/cloud/storage"

class GoogleCloudStorageService
  def initialize
    credentials_path = ENV['GCS_CREDENTIALS_PATH']
    storage_client = Google::Cloud::Storage.new(
      credentials: credentials_path
    )
        # Access the bucket
    bucket_name = ENV['GCS_BUCKET_NAME']
    @bucket = storage_client.bucket(bucket_name)
  end

  def upload_file(file, filename)
    file_obj = @bucket.create_file(file.path, filename, content_type: 'video/mp4')
    file_obj
  end

  def generate_signed_url_for_viewing(filename)
    Rails.logger.debug "Generating signed URL for: #{filename}"
    signed_url = @bucket.signed_url(
      filename,
      method: "GET",
      expires: 15.minutes
    )
    Rails.logger.debug "Signed URL generated: #{signed_url}"
    signed_url
  end
end