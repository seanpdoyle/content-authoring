class ApplicationController < ActionController::Base
  before_action do
    Current.admin_id = session[:admin_id]
  end

  before_action do
    if request.get? && request.xml_http_request?
      request.variant = [:fragment]
    end
  end
end
