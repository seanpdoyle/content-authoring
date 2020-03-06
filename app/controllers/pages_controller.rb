class PagesController < ApplicationController
  def index
    pages = Page.all.order(id: :asc)

    render locals: { pages: pages }
  end
end
