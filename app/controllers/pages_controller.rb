class PagesController < ApplicationController
  def index
    pages = Page.all.order(id: :asc)

    render locals: { pages: pages }
  end

  def show
    page = Page.find(params[:id])

    render locals: { page: page }
  end
end
