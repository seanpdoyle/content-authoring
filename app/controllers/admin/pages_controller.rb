module Admin
  class PagesController < ApplicationController
    def update
      page = Page.find(params[:id])

      page.update!(page_params)

      redirect_back fallback_location: root_path
    end

    private

    def page_params
      params.require(:page).permit(
        :headline,
        :name,
      )
    end
  end
end
