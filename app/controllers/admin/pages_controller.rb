module Admin
  class PagesController < ApplicationController
    def edit
      page = Page.find(params[:id])

      render locals: {
        attribute: params.fetch(:attribute_id),
        page: page,
      }
    end

    def update
      page = Page.find(params[:id])

      page.update!(page_params)

      redirect_back fallback_location: root_path
    end

    private

    def page_params
      params.require(:page).permit(
        :content,
        :headline,
        :information,
        :introduction,
        :name,
      )
    end
  end
end
