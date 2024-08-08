require 'rails_helper'
require 'google/cloud/storage'

RSpec.describe GoogleCloudStorageService, type: :service do
  let(:credentials_path) { 'config/ninkatec-2-223b74173d7a.json' }
  let(:storage_client) { instance_double(Google::Cloud::Storage::Project) }
  let(:bucket) { instance_double(Google::Cloud::Storage::Bucket) }
  let(:file) { instance_double(Google::Cloud::Storage::File) }
  let(:filename) { 'test_video.mp4' }
  let(:local_path) { 'path/to/local/file.mp4' }
  let(:signed_url) { 'http://signed_url_for_uploading' }

  before do
    allow(Google::Cloud::Storage).to receive(:new).with(credentials: credentials_path).and_return(storage_client)
    allow(storage_client).to receive(:bucket).with('ninkatec-bucket-1').and_return(bucket)
  end

  describe '#generate_signed_url_for_viewing' do
    it 'generates a signed URL for viewing a file' do
      allow(bucket).to receive(:signed_url).with(filename, method: 'GET', expires: 15.minutes).and_return(signed_url)

      service = GoogleCloudStorageService.new
      result = service.generate_signed_url_for_viewing(filename)

      expect(result).to eq(signed_url)
    end
  end

  describe '#generate_signed_url_for_uploading' do
    it 'generates a signed URL for uploading a file' do
      allow(bucket).to receive(:signed_url).with(filename, method: 'PUT', expires: 15.minutes, content_type: 'video/mp4').and_return(signed_url)

      service = GoogleCloudStorageService.new
      result = service.generate_signed_url_for_uploading(filename)

      expect(result).to eq(signed_url)
    end
  end

  describe '#download_file' do
    it 'downloads a file from Google Cloud Storage' do
      allow(bucket).to receive(:file).with(filename).and_return(file)
      allow(file).to receive(:download).with(local_path)

      service = GoogleCloudStorageService.new
      expect(Rails.logger).to receive(:debug).with("Downloading file from Google Cloud Storage: #{filename}")
      expect(Rails.logger).to receive(:debug).with("File downloaded to: #{local_path}")

      service.download_file(filename, local_path)
    end
  end
end