require "test_helper"

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @active = users(:tosh)
    @inactive = users(:inactive)
  end

  test "should redirect if the user is inactive" do
    get user_path(@inactive)
    assert_redirected_to root_url
  end

end
