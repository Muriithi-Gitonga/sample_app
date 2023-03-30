require "test_helper"

class UsersSignup < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end
end

class UsersSignupTest < UsersSignup
  # the main purpose is to verify that clicking the signup button results not creating a new user when the submitted info is invalid
  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path,
           params: {
             user: {
               name: "",
               email: "user@invalid",
               password: "foobar",
               password_confirmation: "barfoo"
             }
           }
    end
    assert_response :unprocessable_entity
    assert_template "users/new"
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
  end

  test "valid signup information" do
    assert_difference "User.count" do
      post users_path,
           params: {
             user: {
               name: "test",
               email: "test@example.com",
               password: "password",
               password_confirmation: "password"
             }
           }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
  end
end

class AccountActivationTest < UsersSignup
  def setup
    super
    post users_path,
         params: {
           user: {
             name: "Example",
             email: "example@example.com",
             password: "password",
             password_confirmation: "password"
           }
         }

    @user = assigns(:user)
  end

  test "should not be activated" do
    assert_not @user.activated?
  end

  test "should not be able to log in before activation" do
    log_in_as @user
    assert_not is_logged_in?
  end

  test "should not be able to login with an innvalid activation" do
    get edit_account_activation_path(@user.activation_token, email: "wrong")
    assert_not is_logged_in?
  end

  test "should login successfully with a valid activation token" do
    get edit_account_activation_path(@user.activation_token, email: @user.email)
    assert @user.reload.activated?
    follow_redirect!
    assert_template "users/show"
    assert is_logged_in?
  end
end
