require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:tosh)
    post login_path, params: { session: { email: @user.email, password: 'password' } }
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Signup")
  end

  test "layout links when user is not logged in" do
    delete logout_path
    assert_not is_logged_in?
    get root_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", users_path, count: 0
    get users_path
    assert_redirected_to login_path
    get users_path(@users)
    assert_redirected_to login_path
  end

  test "layout links when user is  logged in" do
    assert is_logged_in?
    get root_path
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", users_path
    get users_path
    
  end
end
