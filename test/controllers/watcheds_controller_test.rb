require 'test_helper'

class WatchedsControllerTest < ActionController::TestCase
  setup do
    @watched = watcheds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:watcheds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create watched" do
    assert_difference('Watched.count') do
      post :create, watched: { add_date: @watched.add_date, movie_id: @watched.movie_id, user_id: @watched.user_id }
    end

    assert_redirected_to watched_path(assigns(:watched))
  end

  test "should show watched" do
    get :show, id: @watched
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @watched
    assert_response :success
  end

  test "should update watched" do
    patch :update, id: @watched, watched: { add_date: @watched.add_date, movie_id: @watched.movie_id, user_id: @watched.user_id }
    assert_redirected_to watched_path(assigns(:watched))
  end

  test "should destroy watched" do
    assert_difference('Watched.count', -1) do
      delete :destroy, id: @watched
    end

    assert_redirected_to watcheds_path
  end
end
