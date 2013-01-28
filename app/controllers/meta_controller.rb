class MetaController < ApplicationController
  respond_to :json

  def show
    respond_with meta_info
  end

  private

  def meta_info
    {
      owner_email: "msolli@gmail.com",
      publication_api_version: "1.0",
      name: "Nostalgia",
      description: "A photo from your <a href='http://www.flickr.com'>Flickr</a> photostream from this date, any year in the past.",
      delivered_on: "every day there is a photo in your Flickr photostream from this date, any year in the past",
      send_timezone_info: true,
      send_delivery_count: false,
      external_configuration: true
    }
  end
end
