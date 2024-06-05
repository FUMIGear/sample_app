require "test_helper"
class UsersLoginTest < ActionDispatch::IntegrationTest
  # リスト 8.34:有効な情報を使ってユーザーがログインできることをテストする
  def setup
    @user = users(:michael)
  end

  # リスト 8.9:フラッシュメッセージの残留をキャッチするテスト red
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  # リスト 8.37:メールアドレスが正しくてパスワードが誤っている場合をテストする
  test "login with valid email/invalid password" do
    get login_path
    assert_template 'sessions/new'
    # debugger
    post login_path, params: {  session: {
      # email:    （コードを書き込む）, password: "invalid"
      email:    @user.email, password: "invalid" #書いてみた
    }}
    assert_not is_logged_in? # リスト8.45
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  # リスト 8.45:ユーザーログアウトのテスト（無効なログインテストも1箇所改良） green
  test "login with valid information followed by logout" do
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end



