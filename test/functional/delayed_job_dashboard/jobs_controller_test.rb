require 'test_helper'

module DelayedJobDashboard
  class JobsControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end
  
  end
end
