require 'test_helper'

class StoatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stoats_index_url
    assert_response :success
  end

  test "should get show" do
    get stoats_show_url
    assert_response :success
  end

end
