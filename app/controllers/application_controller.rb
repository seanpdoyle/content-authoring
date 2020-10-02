class ApplicationController < ActionController::Base
  before_action { request.variant = :admin if cookies[:admin] }
end
