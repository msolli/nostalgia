# -*- coding: utf-8 -*-
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
      description: "A photo from your <a href='http://www.flickr.com'>Flickr</a> photostream from today on a corresponding date in the past.",
      delivered_on: "whenever there’s a photo in your Flickr photostream from the corresponding date in the past",
      send_timezone_info: true,
      send_delivery_count: false,
      external_configuration: true
    }
  end
end
