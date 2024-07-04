require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  # リスト 10.57:admin属性の変更が禁止されていることをテストする
  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
    @admin      = users(:michael) # リスト10.63
    @non_admin  = users(:lana) # リスト10.63
  end

  # singnupページが開けた確認するテスト
  test "should get new" do
    # get users_new_url
    get signup_path
    assert_response :success
  end

  # リスト 10.35:indexアクションのリダイレクトをテストする
  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  # リスト 10.57:admin属性の変更が禁止されていることをテストする
  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                    user: { password:              "password",
                                            password_confirmation: "password",
                                            admin: true} }
                                            # debugger
    assert_not @other_user.admin?
  end

  # リスト 10.62:管理者権限の制御をアクションレベルでテストする green
  # ログアウト状態でdeleteを実行→ログイン画面に移るか。
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end
  # 管理者じゃないアカウントがdeleteを実行→ホーム画面に戻るか
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_response :see_other
    assert_redirected_to root_url
  end

  # リスト 10.63:削除リンクとユーザー削除に対する統合テスト green
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name # ユーザ名の確認
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete' # delete表示を確認
      end
    end
    # deleteアクションが成功するか確認
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
      assert_response :see_other
      assert_redirected_to users_url
    end
  end
  # 管理者でないユーザがログインした場合、deleteという表示がないことを確認
  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
