require 'test_helper'

class PostsControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get posts_controller_index_url
    assert_response :success
  end

end
