module Admin
  class ApplicationController < ::ApplicationController
    before_action { head :forbidden unless request.variant.admin? }
  end
end
