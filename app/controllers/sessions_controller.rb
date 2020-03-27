class SessionsController < ApplicationController
  def create
    session[:admin_id] = 1

    redirect_back fallback_location: root_url
  end

  def destroy
    session.delete(:admin_id)

    redirect_back fallback_location: root_url
  end
end
