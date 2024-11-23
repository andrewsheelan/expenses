require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get '/users/sign_in'
    assert_response :success
  end
end
