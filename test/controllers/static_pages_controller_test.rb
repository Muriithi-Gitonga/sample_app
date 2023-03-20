require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  test "should get home" do
    get root_url
    assert_response :success
    assert_select "title", "Home | #{setup}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | #{setup}"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | #{setup}"
  end

  test "should get contact" do
    get static_pages_contact_url
    assert_response :success
    assert_select "title", "Contact | #{setup}"
  end
end