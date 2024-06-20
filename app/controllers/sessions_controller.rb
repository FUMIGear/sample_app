class SessionsController < ApplicationController
  def new
  end

  # リスト 8.6:Sessionsコントローラのcreateアクション（暫定版）
  # リスト 8.7:ユーザーをデータベースから見つけて検証する
  def create
    # リスト 9.29:createアクション内でインスタンス変数を使うためのテンプレート
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      reset_session
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      log_in @user
      redirect_to @user
      # user = User.find_by(email: params[:session][:email].downcase)
      # if user && user.authenticate(params[:session][:password])
      # if user # && user.authenticate(params[:session][:password]) # リスト8.36
      # if user&.authenticate(params[:session][:password]) # リスト 8.38
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      # リスト 8.15:ユーザーにログインする
      # reset_session # ログインの直前に必ずこれを書くこと
      # params[:session][:remember_me] == '1' ? remember(user) : forget(user) # リスト9.24：追加分
      # remember user # リスト9.7
      # log_in user
      # redirect_to user
    else
      # エラーメッセージを作成する
      # flash[:danger] = 'Invalid email/password combination' # 本当は正しくない
      flash.now[:danger] = 'Invalid email/password combination' # 正しい表記
      render 'new', status: :unprocessable_entity
    end
  end

  # リスト 8.44:セッションを破棄する（ユーザーのログアウト）
  def destroy
    # log_out
    log_out if logged_in? # リスト9.17
    redirect_to root_url, status: :see_other
  end
end
