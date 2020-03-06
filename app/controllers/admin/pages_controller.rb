module Admin
  class PagesController < ApplicationController
    def edit
      page = Page.find(params[:id])

      render locals: { page: page }, layout: !fragment?
    end

    def update
      page = Page.find(params[:id])

      page.update!(page_params)

      redirect_back fallback_location: url_for(page.slug)
    end

    private

    def fragment?
      params.key?(:fragment_id)
    end

    def page_params
      params.require(:page).permit(
        :body_text,
        :headline_text,
        :hero_text,
      )
    end
  end
end
