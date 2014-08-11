require 'test_helper'

class DirectorshipsControllerTest < ActionController::TestCase
  setup do
    @directorship = directorships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:directorships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create directorship" do
    assert_difference('Directorship.count') do
      post :create, directorship: {  }
    end

    assert_redirected_to directorship_path(assigns(:directorship))
  end

  test "should show directorship" do
    get :show, id: @directorship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @directorship
    assert_response :success
  end

  test "should update directorship" do
    put :update, id: @directorship, directorship: {  }
    assert_redirected_to directorship_path(assigns(:directorship))
  end

  test "should destroy directorship" do
    assert_difference('Directorship.count', -1) do
      delete :destroy, id: @directorship
    end

    assert_redirected_to directorships_path
  end
end
