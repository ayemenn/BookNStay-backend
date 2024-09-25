require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get photos" do
    get locations_photos_url
    assert_response :success
  end
end
