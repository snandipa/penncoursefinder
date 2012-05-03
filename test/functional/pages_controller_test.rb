require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get queryresult" do
    get :queryresult
    assert_response :success
  end

  test "should get queryall" do
    get :queryall
    assert_response :success
  end

end
