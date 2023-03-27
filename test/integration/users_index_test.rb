require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:tosh)
    @non_admin = users(:grace)
  end

  test "index including pagination" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    User.paginate(page:1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
      assert_response :see_other
      assert_redirected_to users_url
    end 
  end

  test "index aa non-admin" do
    log_in_as @non_admin
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

end
