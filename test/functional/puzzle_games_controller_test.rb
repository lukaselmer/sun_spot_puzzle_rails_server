require 'test_helper'

class PuzzleGamesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:puzzle_games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create puzzle_game" do
    assert_difference('PuzzleGame.count') do
      post :create, :puzzle_game => { }
    end

    assert_redirected_to puzzle_game_path(assigns(:puzzle_game))
  end

  test "should show puzzle_game" do
    get :show, :id => puzzle_games(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => puzzle_games(:one).to_param
    assert_response :success
  end

  test "should update puzzle_game" do
    put :update, :id => puzzle_games(:one).to_param, :puzzle_game => { }
    assert_redirected_to puzzle_game_path(assigns(:puzzle_game))
  end

  test "should destroy puzzle_game" do
    assert_difference('PuzzleGame.count', -1) do
      delete :destroy, :id => puzzle_games(:one).to_param
    end

    assert_redirected_to puzzle_games_path
  end
end
