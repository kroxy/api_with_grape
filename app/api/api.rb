require 'grape-swagger'


class API < Grape::API
  prefix 'api'
  version 'v0.1', using: :path


  rescue_from ActiveRecord::RecordNotFound do |e|
    Rack::Response.new({
                           error_code: 404,
                           error_message: e.message
                       }.to_json, 404).finish
  end

  rescue_from :all do |e|
    Rack::Response.new({
                           error_code: 500,
                           error_message: e.message
                       }.to_json, 500).finish

  end
  mount Music::Store

  add_swagger_documentation api_version:'v0.1', mount_path: "/docs"
end
private

def authenticate
  authenticate_or_request_with_http_token do |token, options|
    @user = User.where(api_key: token).first
  end
end