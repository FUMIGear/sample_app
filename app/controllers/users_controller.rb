class UsersController < ApplicationController
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

  private

  # リスト 7.19:createアクションでStrong Parametersを使う
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
