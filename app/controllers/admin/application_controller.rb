module Admin
  class ApplicationController < ApplicationController
    before_action do
      if Current.admin_id.nil?
        flash.alert = translate("admin.application.not_authorized")

        redirect_back fallback_location: root_url
      end
    end
  end
end
