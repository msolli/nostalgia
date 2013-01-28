class EditionsController < ApplicationController
  before_filter :validator_check, only: :show

  def show
    user = User.find_by_access_token(access_token)
    date = Date.parse local_delivery_time
    if stale?(etag: date.strftime + access_token, public: true)
      unless @photo = FlickrSearch.from_user(user).random_from_date(date)
        render nothing: true, status: :ok
      end
    end
  end

  def sample
    @photo = flickr.photos.getInfo(photo_id: "4022770048")
    render "show"
  end

  private

  def access_token
    params.require(:access_token)
  end

  def local_delivery_time
    params.require(:local_delivery_time)
  end

  def validator_check
    if params[:test]
      render nothing: true, status: :ok
    end
  end
end
