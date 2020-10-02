class SessionsController < ApplicationController
  def create
    cookies[:admin] = true

    redirect_back fallback_location: root_url
  end

  def destroy
    cookies.delete(:admin)

    redirect_back fallback_location: root_url
  end
end
