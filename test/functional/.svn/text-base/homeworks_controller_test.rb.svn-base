require 'test_helper'

class HomeworksControllerTest < ActionController::TestCase
  include AuthenticatedTestHelper
  
  fixtures :homeworks
  
  
  test "should revert complete" do
    login_as :quentin
    
    xhr :get, :status, :id => homeworks(:one).id, :status => "not"
    
    assert_response :success
    assert_template "status"
    assert_not_nil assigns(:homework)
    assert assigns(:homework).length > assigns(:homework).length_done, "The length done must be less than length\nLength: #{homeworks(:one).length}\nLength done: #{homeworks(:one).length_done}"
    
    assert_not_nil assigns(:subjects)
  end

  test "should set as complete" do
    login_as :quentin
    
    xhr :get, :status, :id => homeworks(:one).id, :status => "done"
    
    assert_response :success
    assert_template "status"
    assert_not_nil assigns(:homework)
    assert assigns(:homework).length == assigns(:homework).length_done, "The length done is not equal to length after sending done signal\nLength: #{homeworks(:one).length}\nLength done: #{homeworks(:one).length_done}"
    
    assert_not_nil assigns(:subjects)
  end
    
  test "should show ajax form for new" do
    login_as :quentin
    xhr :get, :new
    assert_response :success
  end
  
  test "should not let in if not logged" do
    id = homeworks(:one).id
    
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
  test "should create homework" do
    login_as :quentin
    assert_difference('Homework.count') do
      post :create, :homework => { :when => "5.8.2009" }
    end
  
    assert_redirected_to homeworks_path
  end
  
  test "should create homework with ajax" do
    login_as :quentin
    assert_difference('Homework.count') do
      xhr :post, :create, :homework => { :when => "4.7.2009", :subject_id => subjects(:matematika).id }
      assert assigns(:homework).errors.empty?
    end
  end
  
  test "should not create homework without date" do
    login_as :quentin
    post :create, :homework => {}
    assert !assigns(:homework).errors.empty?
    assert_not_nil assigns(:homework).errors.on(:when)
  end
  
  # 
  test "should show homework" do
    login_as :quentin
    get :show, :id => homeworks(:one).id
    assert_response :success
  end
  
  test "should get edit" do
    login_as :quentin
    get :edit, :id => homeworks(:one).id
    assert_response :success
  end
  
  test "should update homework" do
    login_as :quentin
    put :update, :id => homeworks(:one).id, :homework => { }
    assert_redirected_to homeworks_path
  end
  
  test "should destroy homework" do
    login_as :quentin
    assert_difference('Homework.count', -1) do
      delete :destroy, :id => homeworks(:one).id
    end
  
    assert_redirected_to homeworks_path
  end
end
