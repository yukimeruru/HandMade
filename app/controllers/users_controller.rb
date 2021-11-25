class UsersController < ApplicationController
  before_action :autheniticate_user!

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @items = @user.items.page(params[:page]).per(18)
  end

  def out
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def followeds
    user = User.find(params[:id])
    @users = user.followeds
  end

  def bookmarks
    user = User.find(params[:id])
    @bookmarks = Bookmark.where(user_id: user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

end
