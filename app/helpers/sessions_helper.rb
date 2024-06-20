module SessionsHelper
  # リスト8.14:渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
    session[:session_token] = user.session_token # リスト 9.38
  end

  # リスト 9.8:ユーザーを記憶する
  # 永続的セッションのためにユーザーをデータベースに記憶する
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # リスト 8.16:セッションに含まれる現在のユーザーを検索する
  # current_userの定義。現在ログイン中のユーザーを返す（いる場合）
  # def current_user
  #   if session[:user_id]
  #     @current_user ||= User.find_by(id: session[:user_id])
  #   end
  # end

  # リスト 9.9:永続的セッションのcurrent_userを更新する
  # リスト 9.31:テストされていないブランチで例外を発生する
  # リスト 9.38:ログイン時にセッショントークンを設定する
  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id])
      # @current_user ||= User.find_by(id: user_id)
      user = User.find_by(id: user_id)
      # debugger
      if user && session[:session_token] == user.session_token # リスト9.38
        @current_user = user
      end
    elsif (user_id = cookies.encrypted[:user_id]) # リスト9.35:raiseをコメントアウト
      # raise       # 追加分：テストがパスすれば、この部分がテストされていないことがわかる
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # リスト 8.18:logged_in?ヘルパーメソッド
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # リスト 9.12:永続的セッションからログアウトする green
  # app/helpers/sessions_helper.rb
  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    # debugger
  end

  # リスト 8.43:log_outメソッド
  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user) # リスト9.12追加分
    reset_session
    @current_user = nil   # 安全のため
  end
end
