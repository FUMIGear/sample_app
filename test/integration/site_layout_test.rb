require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    # @other_user = users(:archer) # リスト10.24
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
  end

  # 演習10.3.1
  test "ログイン状態で使えるサイト" do
    log_in_as(@user)
    get users_path
    # header
    assert_template 'users/index'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    # assert_select "a[href=?]", current_user
    # assert_select "a[href=?]", "users#show"
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    # assert_not_select "a[href=?]", login_path
    # footer
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end
end
