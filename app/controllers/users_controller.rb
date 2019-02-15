class UsersController < ApplicationController
    before_action :require_user_logged_in, only: [:show, :mypage, :myfavorite]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if  @user.save
        flash[:success]='ユーザー登録が完了しました'
        redirect_to login_url
    else
        flash.now[:danger]='ユーザー登録に失敗しました'
        render :new
    end 
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  def mypage
    @user = current_user
    @posts = current_user.posts.all.page(params[:page]).per(5)
  end 
  def favoriting
    @user = User.find(params[:id])
    @favorites = @user.favoriting
  end 
  def myfavorite
    @myfavorites = current_user.favoriting.page(params[:page]).per(5)
  end 
end

private
def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end 