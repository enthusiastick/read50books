class UsersController < ApplicationController

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @gravatar_url = Gravatar.new(@user.email).image_url
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
    @facebook_share_url = 'http://www.read50books.com' + user_path(@user)
  end

end
