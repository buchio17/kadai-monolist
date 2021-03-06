class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
    @user = User.find(params[:id])
    @items = @user.items.uniq
    @count_want = @user.want_items.count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    
    if @user.save
      flash[:success] = 'ユーザーを登録しました。'
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  def params_user
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
