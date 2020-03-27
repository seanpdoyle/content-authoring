module Admin
  class PagesController < ApplicationController
    def update
      page = Page.find(params[:id])

      page.update!(page_params)

      redirect_back fallback_location: url_for(page.slug)
    end

    private

    def page_params
      params.require(:page).permit(
        :body_text,
        :headline_text,
        :hero_text,
      )
    end
  end
end
