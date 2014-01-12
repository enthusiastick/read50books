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
        @book.author = @book_hash.authors.author.name
      else
        @book.author = @book_hash.author
      end
    end
    @book.user = @user
    if @book.save
      flash['alert-box success'] = "Nice work!"
      redirect_to user_book_path(@user, @book)
    else
      flash.now['alert-box alert'] = "Error! Please check your input and retry."
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
      flash.now['alert-box alert'] = 'No results returned.'
      # redirect_to user_path(@user)
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

  protected

  def book_params
    params.require(:book).permit(:author, :title, :date_completed, :user_id, :goodreads_id)
  end

end
