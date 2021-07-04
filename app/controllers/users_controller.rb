class UsersController < ApplicationController
before_action :authenticate_user!
before_action :ensure_correct_user,only: [:edit, :update]
  def show
       @user = User.find(params[:id])
       @books=@user.books.all
       @book=Book.new
  end

  def edit
       @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
      flash[:notice] =  "You have updated user successfully."
      redirect_to user_path(@user)
     else
      render :edit
     end
  end

  def index
   @users = User.all
   @book=Book.new
   @user=current_user
  end

  private
  # ストロングパラメータ
  def user_params
     params.require(:user).permit(:profile_image, :name, :introduction)
  end
  
 def ensure_correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
 end


end
