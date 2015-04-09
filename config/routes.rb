Rails.application.routes.draw do
  devise_for :users
  mount API =>'/'
  get "/docs" => 'docs#index'
end
