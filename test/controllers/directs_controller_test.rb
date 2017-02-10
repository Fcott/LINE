require 'test_helper'

class DirectsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get directs_show_url
    assert_response :success
  end

end
