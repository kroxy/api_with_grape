class DocsController < ApplicationController
  http_basic_authenticate_with name: "tibi", password: "titok", except: :index
end
