class ApplicationController < ActionController::Base
  before_action do
    Current.admin_id = session[:admin_id]
  end
end
