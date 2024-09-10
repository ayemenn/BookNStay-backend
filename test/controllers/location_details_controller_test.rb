require "test_helper"

class LocationDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get location_details_show_url
    assert_response :success
  end
end
