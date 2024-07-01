class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update] # リスト10.15
  before_action :correct_user,   only: [:edit, :update] # リスト10.25

  # リスト7.5
  def show
    @user = User.find(params[:id])
    # debugger
  end

  def new
    @user = User.new
    # debugger
  end

  # リスト 7.18:ユーザー登録の失敗に対応できるcreateアクション
  def create
    # @user = User.new(params[:user])    # 実装は終わっていないことに注意!
    @user = User.new(user_params) #リスト7.19
    if @user.save
    # if false # 演習7.7.4-4
      reset_session # リスト 8.39
      log_in @user # リスト 8.39
      flash[:success] = "Welcome to the Sample App!" #リスト7.27：ここで好きなキーとメッセージ入れてる
      redirect_to @user # リスト7.26
      # redirect_to user_url(@user) # 演習7.4.1結果同じはず
    else
      render 'new', status: :unprocessable_entity
      # debugger
    end
  end

  # リスト 10.1:ユーザーのeditアクション
  def edit
    @user = User.find(params[:id])
  end

  # リスト 10.8:ユーザーのupdateアクションの初期実装
  # リスト 10.12:ユーザーのupdateアクション
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated" # リスト10.12
      redirect_to @user # リスト10.12
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  # リスト 7.19:createアクションでStrong Parametersを使う
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # リスト 10.15:beforeフィルターにlogged_in_userを追加する red
  # beforeフィルタ
  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location # リスト10.32
      flash[:danger] = "Please log in."
      redirect_to login_url, status: :see_other
    end
  end

  # リスト 10.25:beforeフィルターを使って編集/更新ページを保護する green
  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url, status: :see_other) unless @user == current_user
  end
end
