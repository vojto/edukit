require 'test_helper'

class OverviewControllerTest < ActionController::TestCase
  include AuthenticatedTestHelper
  fixtures :users
  fixtures :subjects
    
  def setup
    login_as :quentin
  end
  
  test "should show message at overview if subjects sum is zero" do
    get :index
    assert_equal assigns(:current_user).subjects.sum(:time), 0, "Subjects time should be zero"
    assert_select "p#tooltip_empty"
  end
  
  test "should show stuff to do" do
    get :index
    assert_not_nil assigns(:subjects)
    assert_select("ul.dashboard")
    # TODO check for unfinished and finished subjects    
  end
  
  test "should load homeworks on dashboard" do
    get :index
    assert_not_nil assigns(:homeworks)
    assert_select("ul.homeworks")
  end
  
  test "should load exams on dashboard" do
    get :index
    assert_not_nil assigns(:exams)
    assert_select("ul.exams")
  end
  
  test "should mark something as complete" do
    xhr :get, :setComplete, :id => subjects(:matematika).id
    assert_response :success
  end
  
  test "should revert something from being complete" do
    
  end
end
