require 'test_helper'

class ExamsControllerTest < ActionController::TestCase
  include AuthenticatedTestHelper
  
  fixtures :exams
  
  
  test "should revert complete" do
    login_as :quentin
    
    xhr :get, :status, :id => exams(:one).id, :status => "not"
    
    assert_response :success
    assert_template "status"
    assert_not_nil assigns(:exam)
    assert assigns(:exam).length > assigns(:exam).length_done, "The length done must be less than length\nLength: #{exams(:one).length}\nLength done: #{exams(:one).length_done}"
    
    assert_not_nil assigns(:subjects)
  end

  test "should set as complete" do
    login_as :quentin
    
    xhr :get, :status, :id => exams(:one).id, :status => "done"
    
    assert_response :success
    assert_template "status"
    assert_not_nil assigns(:exam)
    assert assigns(:exam).length == assigns(:exam).length_done, "The length done is not equal to length after sending done signal\nLength: #{exams(:one).length}\nLength done: #{exams(:one).length_done}"
    
    assert_not_nil assigns(:subjects)
  end
    
  test "should show ajax form for new" do
    login_as :quentin
    xhr :get, :new
    assert_response :success
  end
  
  test "should not let in if not logged" do
    id = exams(:one).id
    
    get :index
    assert_response 302
    
    get :new
    assert_response 302
    
    post :create
    assert_response 302
    
    get :show, :id => id
    assert_response 302
    
    get :edit, :id => id
    assert_response 302
    
    put :update, :id => id
    assert_response 302
    
    delete :destroy, :id => id
    assert_response 302
  end
  
  test "should get index" do
    login_as :quentin
    get :index
    assert_response :success
    assert_not_nil assigns(:days)
  end
  # 
  test "should get new" do
    login_as :quentin
    get :new
    assert_response :success
  end
  # 
  test "should create exam" do
    login_as :quentin
    assert_difference('Exam.count') do
      post :create, :exam => { :when => "5.8.2009" }
    end
  
    assert_redirected_to exams_path
  end
  
  test "should create exam with ajax" do
    login_as :quentin
    assert_difference('Exam.count') do
      xhr :post, :create, :exam => { :when => "4.7.2009", :subject_id => subjects(:matematika).id }
      assert assigns(:exam).errors.empty?
    end
  end
  
  test "should not create exam without date" do
    login_as :quentin
    post :create, :exam => {}
    assert !assigns(:exam).errors.empty?
    assert_not_nil assigns(:exam).errors.on(:when)
  end
  
  # 
  test "should show exam" do
    login_as :quentin
    get :show, :id => exams(:one).id
    assert_response :success
  end
  
  test "should get edit" do
    login_as :quentin
    get :edit, :id => exams(:one).id
    assert_response :success
  end
  
  test "should update exam" do
    login_as :quentin
    put :update, :id => exams(:one).id, :exam => { }
    assert_redirected_to exams_path
  end
  
  test "should destroy exam" do
    login_as :quentin
    assert_difference('Exam.count', -1) do
      delete :destroy, :id => exams(:one).id
    end
  
    assert_redirected_to exams_path
  end
end
