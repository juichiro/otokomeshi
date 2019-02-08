class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :show, :destroy, :today_recipe]
  
  def new
    @post = current_user.posts.build
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(params_post)
    if @post.save
      flash[:success]='投稿が完了しました'
      redirect_to @post
    else 
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end  
  end
  def edit
  end

  def update
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.destroy
      flash[:success]='削除に成功しました'
      redirect_to root_url
    else
      flash[:danger]='削除できませんでした'
      redirect_to @post
    end 
  end
  def favorited
    @post = Post.find(params[:id])
    @favorited_users = @post.favorited 
  end
  
  def today_recipe
   posts = Post.all
   @today_recipe = posts.sample
  end 
  private
   def params_post
     params.require(:post).permit(:content, :post_image, :name)
   end
end 
