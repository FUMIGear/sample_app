class SessionsController < ApplicationController
  def new
  end

  # リスト 8.6:Sessionsコントローラのcreateアクション（暫定版）
  # リスト 8.7:ユーザーをデータベースから見つけて検証する
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # if user && user.authenticate(params[:session][:password])
    # if user # && user.authenticate(params[:session][:password]) # リスト8.36
    if user&.authenticate(params[:session][:password]) # リスト 8.38
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      # リスト 8.15:ユーザーにログインする
      reset_session      # ログインの直前に必ずこれを書くこと
      log_in user
      redirect_to user
    else
      # エラーメッセージを作成する
      # flash[:danger] = 'Invalid email/password combination' # 本当は正しくない
      flash.now[:danger] = 'Invalid email/password combination' # 正しい表記
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
  end


end
