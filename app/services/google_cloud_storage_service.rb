require "google/cloud/storage"

class GoogleCloudStorageService
  def initialize
    credentials_path = 'config/ninkatec-2-d2112f9ef735.json'
    storage_client = Google::Cloud::Storage.new(
      credentials: credentials_path
    )
        # Access the bucket
    bucket_name = 'ninkatec-bucket-1'
    @bucket = storage_client.bucket(bucket_name)
  end

  # def upload_file(file, filename)
  #   file_obj = @bucket.create_file(file.path, filename, content_type: 'video/mp4')
  #   file_obj
  # end

  def generate_signed_url_for_viewing(filename)
    # Rails.logger.debug "Generating signed URL for: #{filename}"
    signed_url = @bucket.signed_url(
      filename,
      method: "GET",
      expires: 15.minutes
    )
    # Rails.logger.debug "Signed URL generated: #{signed_url}"
    signed_url
  end

  def generate_signed_url_for_uploading(filename)
    Rails.logger.debug "Generating signed URL for: #{filename}"
    signed_url = @bucket.signed_url(
      filename,
      method: "PUT",
      expires: 15.minutes,
      content_type: 'video/mp4'
    )
    Rails.logger.debug "Signed URL generated: #{signed_url}"
    signed_url
  end

  def download_file(filename, local_path)
    Rails.logger.debug "Downloading file from Google Cloud Storage: #{filename}"
    file = @bucket.file(filename)
    file.download(local_path)
    Rails.logger.debug "File downloaded to: #{local_path}"
  end
end