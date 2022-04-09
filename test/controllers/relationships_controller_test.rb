require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index_follow" do
    get relationships_index_follow_url
    assert_response :success
  end

  test "should get index_follower" do
    get relationships_index_follower_url
    assert_response :success
  end

end
