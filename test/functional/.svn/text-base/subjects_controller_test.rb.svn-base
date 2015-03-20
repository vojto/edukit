require 'test_helper'

class SubjectsControllerTest < ActionController::TestCase
  include AuthenticatedTestHelper
  
  fixtures :subjects
  
  test "should get index" do
    login
    get :index
    assert_response :success
    assert_not_nil assigns(:subjects)
  end
  
  test "should get new" do
    login
    get :new
    assert_response :success
  end
  
  test "should create subject" do
    login
    assert_difference('Subject.count') do
      r = post :create, :subject => { :title => "Anglictina" }
    end
  
    assert_redirected_to subjects_path
  end
  
  test "should get edit" do
    login
    get :edit, :id => subjects(:matematika).id
    assert_response :success
  end
  
  test "should update subject" do
    login
    put :update, :id => subjects(:matematika).id, :subject => { }
    assert_redirected_to subjects_path
  end
  
  test "should destroy subject" do
    login
    assert_difference('Subject.count', -1) do
      delete :destroy, :id => subjects(:slovencina).id
    end
  
    assert_redirected_to :controller => "subjects", :action => "settings"
  end
  
  test "ajax should destroy subject" do
    login
    delete :destroy, :id => subjects(:matematika).id, :format => "js"
    assert_response :success
    assert_template "destroy"
  end
  
  private
  
  def login
    login_as :quentin
  end
end
