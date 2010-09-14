require 'test_helper'

class SpotActivitiesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spot_activities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spot_activity" do
    assert_difference('SpotActivity.count') do
      post :create, :spot_activity => { }
    end

    assert_redirected_to spot_activity_path(assigns(:spot_activity))
  end

  test "should show spot_activity" do
    get :show, :id => spot_activities(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => spot_activities(:one).to_param
    assert_response :success
  end

  test "should update spot_activity" do
    put :update, :id => spot_activities(:one).to_param, :spot_activity => { }
    assert_redirected_to spot_activity_path(assigns(:spot_activity))
  end

  test "should destroy spot_activity" do
    assert_difference('SpotActivity.count', -1) do
      delete :destroy, :id => spot_activities(:one).to_param
    end

    assert_redirected_to spot_activities_path
  end
end
