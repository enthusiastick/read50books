class UsersController < ApplicationController

  def show
    @book = Book.new
    @user = User.find(params[:id])
    unless @user.books == nil
      @books = @user.books.order(:date_completed)
      @books_by_year = Hash.new
      @books.each do |book|
        if @books_by_year.has_key?(book.year)
          @books_by_year[book.year] << book
        else
          @books_by_year[book.year] = [book]
        end
      end
    end
  end

end
