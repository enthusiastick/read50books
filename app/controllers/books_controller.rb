class BooksController < ApplicationController

  before_action :authenticate_user, only: [:create, :new]
  before_action :set_user

  def index
    @search = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = @user
    if @book.save
      flash['alert-box success'] = "Nice work!"
      redirect_to user_book_path(@user, @book)
    else
      flash.now['alert-box alert'] = "Error! Please check your input and retry."
      render :new
    end
  end

  def new
    search = BookSearch.new(params[:q])
    @results_collection = search.perform
    if @results_collection == nil
      flash.now['alert-box alert'] = 'Unable to send message. Please retry.'
      redirect_to user_path(@user)
    else
      @book = Book.new
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  protected

  def book_params
    params.require(:book).permit(:author, :title, :date_completed, :user_id)
  end

end
