require 'test_helper'

class PosicoesControllerTest < ActionController::TestCase
  test "should get get" do
    get :get
    assert_response :success
  end

end
