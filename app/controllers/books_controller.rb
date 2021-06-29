class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user,only: [:edit, :update]
  def create
    @book =  Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user =  current_user
      render :index
    end

  end

  def index
     @books = Book.all
     @book = Book.new
     @user=current_user
  end

  def show
     @book = Book.find(params[:id])
     @user = @book.user
     @books = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user

  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user =  current_user
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def ensure_correct_user
    @book = Book.find(params[:id])
    if @book.user.id != current_user.id
      redirect_to books_path
    end
  end


end
