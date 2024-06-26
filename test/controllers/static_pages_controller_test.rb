require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  # test "should get root" do
    # get root_url
  #   assert_response :success
  # end

  test "should get home" do
    get root_path # リスト5.27
    # get static_pages_home_url
    assert_response :success
    # assert_select "title", "Home | #{@base_title}"
    assert_select "title", "Ruby on Rails Tutorial Sample App" # リスト4.4
  end

  test "should get help" do
    # get helf_path # リスト5.27
    get help_path # リスト5.27
    # get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get about_path # リスト5.27
    # get static_pages_about_url
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  # 演習3.4.3
  test "should get contact" do
    get contact_path # リスト5.27
    # get static_pages_contact_url
    assert_response :success
    assert_select "title", "Contact | Ruby on Rails Tutorial Sample App"
  end
end
