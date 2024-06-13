class PhotosController < ApplicationController
  def new
    @photos = Array.new(4) { Photo.new }
  end

  def create
    @photos = photo_params.map do |photo_param|
      Photo.new(photo_param)
    end

    if @photos.all?(&:save)
      redirect_to photos_path, notice: 'Photos were successfully uploaded.'
    else
      render :new
    end
  end

  private

  def photo_params
    params.require(:photos).map do |photo|
      photo.permit(:image, :tag)
    end
  end
end
