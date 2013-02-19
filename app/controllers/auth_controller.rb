class AuthController < ApplicationController
  def configure
    session[:return_url] = bergcloud_return_url
    token = flickr.get_request_token(oauth_callback: oauth_return_url)
    session[:oauth_token_secret] = token['oauth_token_secret']
    auth_url = flickr.get_authorize_url(token['oauth_token'], perms: 'read')
    redirect_to auth_url
  end

  def oauth_return
    access = flickr.get_access_token(oauth_token,
                                     session[:oauth_token_secret],
                                     oauth_verifier)

    nsid = URI.decode(access['user_nsid'])
    user_attrs = {
      access_token: access['oauth_token'],
      access_secret: access['oauth_token_secret'],
      name: URI.decode(access['fullname'])
    }

    user = User.where(nsid: nsid).first_or_create!
    user.update_attributes!(user_attrs)

    redirect_to "#{session[:return_url]}?config[access_token]=#{user.access_token}"
  end

  private

  def bergcloud_return_url
    params.require(:return_url)
  end

  def oauth_token
    params.require(:oauth_token)
  end

  def oauth_verifier
    params.require(:oauth_verifier)
  end
end
