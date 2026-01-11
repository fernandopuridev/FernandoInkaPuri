require "test_helper"

class PoliciesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get policies_index_url
    assert_response :success
  end

  test "should get new" do
    get policies_new_url
    assert_response :success
  end

  test "should get create" do
    get policies_create_url
    assert_response :success
  end
end
