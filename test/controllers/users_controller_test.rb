require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    # get users_new_url
    get signup_path
    assert_response :success
  end

  # リスト 10.35:indexアクションのリダイレクトをテストする red
  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end
end
