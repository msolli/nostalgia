Nostalgia::Application.routes.draw do
  resource :meta, only: :show
  resource :edition, only: :show
  get "/sample" => "editions#sample"
  get "/configure" => "auth#configure"
  get "/oauth_return" => "auth#oauth_return"
end
