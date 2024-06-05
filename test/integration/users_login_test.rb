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
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

end
