class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end

  def new
    @user = User.new
    @btn = "新規登録"
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ようこそサンプルAppへ"
      redirect_to @user
    else
      render 'new'
      @btn = "新規登録"
    end
  end
  
  # ここから 課題1で追加
  def edit
    @btn = "編集"
  end
  
  def update
    if @user.update(user_params)
      redirect_to @user , notice: 'ユーザ情報を編集しました！'
    else
      render 'edit'
      @btn = "編集"
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
  
  def correct_user
    if @user != current_user
      redirect_to root_path
    end
    
    #redirect_to root_path if @user != current_user
  end
end