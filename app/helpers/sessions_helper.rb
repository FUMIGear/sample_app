module SessionsHelper
  # リスト8.14:渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # リスト 8.16:セッションに含まれる現在のユーザーを検索する
  # current_userの定義。現在ログイン中のユーザーを返す（いる場合）
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # リスト 8.18:logged_in?ヘルパーメソッド
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # リスト 8.43:log_outメソッド
  # 現在のユーザーをログアウトする
  def log_out
    reset_session
    @current_user = nil   # 安全のため
  end
end
