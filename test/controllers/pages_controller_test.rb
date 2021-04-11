require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get link" do
    get pages_link_url
    assert_response :success
  end

end
