class BooksController < ApplicationController

  before_action :authenticate_user, only: [:create, :new]
  before_action :set_user

  def index
    @search = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.title == nil
      @search = BookSearch.new('')
      @book_hash = @search.id(@book.goodreads_id)
      @book.title = @book_hash.title
      if @book_hash.author == nil
        if @book_hash.authors.author.kind_of?(Array)
          @book.author = @book_hash.authors.author[0].name
        else
          @book.author = @book_hash.authors.author.name
        end
      else
        @book.author = @book_hash.author
      end
    end
    @book.user = @user
    if @book.save
      flash['success'] = "Nice work!"
      redirect_to user_book_path(@user, @book)
      award_badge(@user)
    else
      flash.now['alert'] = "Error! Please check your input and retry."
      render :new
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    redirect_to user_path(@user)
  end

  def new
    search = BookSearch.new(params[:q])
    @results_collection = search.perform
    if @results_collection == []
      flash.now['warning'] = 'No results returned. Please enter information manually.'
    end
      @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    unless @book.goodreads_id == nil
      @search = BookSearch.new('')
      @book_hash = @search.id(@book.goodreads_id)
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(update_params)
      flash['success'] = "Book notes updated."
      redirect_to user_path(@user)
    else
      flash.now['alert'] = 'Error. Please check your input and retry.'
      render :show
    end
  end

  protected

  def award_badge(user)
    unless user.books == nil
      books = user.books.order(:date_completed)
      books_by_year = Hash.new
      books.each do |book|
        if books_by_year.has_key?(book.year)
          books_by_year[book.year] << book
        else
          books_by_year[book.year] = [book]
        end
      end
    end
    if books_by_year.values.last.size == 1
      flash['success'] = "Congratulations! You just read your first book of #{books_by_year.keys.last}. You get a badge!"
    elsif books_by_year.values.last.size == 5
      flash['success'] = "Congratulations! You read five books in #{books_by_year.keys.last}. You get a badge!"
    elsif books_by_year.values.last.size == 10
      flash['success'] = "Congratulations! You read ten books in #{books_by_year.keys.last}. You get a badge!"
    elsif books_by_year.values.last.size == 25
      flash['success'] = "Congratulations!!! You read twenty-five books in #{books_by_year.keys.last}. Halfway there! You get a badge!"
    elsif books_by_year.values.last.size == 25
      flash['success'] = "CONGRATULATIONS!!! You read fifty books in #{books_by_year.keys.last}! Unbelievable!"
    end
  end

  def book_params
    params.require(:book).permit(:author, :title, :date_completed, :user_id, :goodreads_id)
  end

  def update_params
    params.require(:book).permit(:brief, :note)
  end

end
