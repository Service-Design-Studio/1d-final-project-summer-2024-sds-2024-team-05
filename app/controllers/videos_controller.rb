class VideosController < ApplicationController
  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to videos_path, notice: 'Video was successfully uploaded.'
    else
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit(:file)
  end
end
