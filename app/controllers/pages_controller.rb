class PagesController < ApplicationController
  def index
    pages = Page.all

    render locals: { pages: pages }
  end

  def show
    page = Page.find_by!(slug: params[:id])

    render locals: { page: page }
  end
end
