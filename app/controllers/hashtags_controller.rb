class HashtagsController < ApplicationController
  decorates_assigned :hashtag

  # GET /hashtags
  # GET /hashtags.json
  def index
    @hashtags = Hashtag.all
    respond_with @hashtags
  end

  # GET /hashtags/1
  # GET /hashtags/1.json
  def show
    @hashtag = Hashtag.find(params[:id]) || Hashtag.find_or_create_by(text: params[:id])
    respond_with @hashtag
  end

end
