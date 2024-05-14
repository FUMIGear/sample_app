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
end
