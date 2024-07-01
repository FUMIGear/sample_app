# リスト 10.9:編集の失敗に対するテスト
# test/integration/users_edit_test.rb
require "test_helper"
class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer) # リスト10.24
  end

  test "unsuccessful edit" do
    log_in_as(@user) # リスト10.17
    get edit_user_path(@user) # 編集画面を入手
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "", email: "foo@invalid", password: "foo", password_confirmation: "bar" } }
    assert_template 'users/edit'
    # debugger # なぜかデバッグ内で下記のテストをするとエラーになる。
    assert_select "div.alert", "The form contains 4 errors."
  end

  # リスト 10.11:編集の成功に対するテスト red
  test "successful edit" do
    log_in_as(@user) # リスト10.17
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name, email: email, password: "", password_confirmation: ""} }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

  # リスト 10.20:editとupdateアクションの保護に対するテストする
  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # リスト 10.24:間違ったユーザーが編集しようとしたときのテスト red
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end
  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  # リスト 10.30:フレンドリーフォワーディングのテスト red
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    assert_equal session[:forwarding_url], edit_user_url(@user) # テストをパスする
    log_in_as(@user)
    # assert_equal session[:forwarding_url], edit_user_url(@user) # エラーになる
    # debugger
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
      email: email,
      password:              "",
      password_confirmation: "" } }
      assert_not flash.empty?
      assert_redirected_to @user
      @user.reload
      assert_equal name,  @user.name
      # debugger
    assert_equal email, @user.email

    # assert_equal "http://www.example.com/users/762146111/edit", edit_user_url(@user)
  end
end
