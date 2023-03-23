require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # the main purpose is to verify that clicking the signup button results not creating a new user when the submitted info is invalid
  test 'Invalid singup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name: '', email: 'user@invalid', password:"foobar", password_confirmation: 'barfoo'}}
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
  end

  # Todo: Write tests for error messages

  test 'Valid SignUp information' do 
    assert_difference 'User.count' do 
      post users_path, params: {user: {name: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password'}}
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
