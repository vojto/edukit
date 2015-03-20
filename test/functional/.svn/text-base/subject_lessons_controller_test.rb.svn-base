require 'test_helper'

class SubjectLessonsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subject_lessons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subject_lesson" do
    assert_difference('SubjectLesson.count') do
      post :create, :subject_lesson => { }
    end

    assert_redirected_to subject_lesson_path(assigns(:subject_lesson))
  end

  test "should show subject_lesson" do
    get :show, :id => subject_lessons(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => subject_lessons(:one).id
    assert_response :success
  end

  test "should update subject_lesson" do
    put :update, :id => subject_lessons(:one).id, :subject_lesson => { }
    assert_redirected_to subject_lesson_path(assigns(:subject_lesson))
  end

  test "should destroy subject_lesson" do
    assert_difference('SubjectLesson.count', -1) do
      delete :destroy, :id => subject_lessons(:one).id
    end

    assert_redirected_to subject_lessons_path
  end
end
