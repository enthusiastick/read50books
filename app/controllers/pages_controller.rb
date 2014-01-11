class PagesController < ApplicationController

  def index
    @book_search = BookSearch.new
  end

end
