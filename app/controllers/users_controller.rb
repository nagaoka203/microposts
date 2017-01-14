class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ようこそサンプルAppへ"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  # ここから 課題1で追加
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to root_path , notice: 'ユーザ情報を編集しました！'
    else
      render 'edit'
    end
  end
  # ここまで
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :location,
                                 :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end