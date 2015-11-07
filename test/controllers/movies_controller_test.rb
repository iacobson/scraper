require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  setup do
    @movie = movies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie" do
    assert_difference('Movie.count') do
      post :create, movie: { director: @movie.director, genre: @movie.genre, hotness: @movie.hotness, image_url: @movie.image_url, rating: @movie.rating, runtime: @movie.runtime, synopsis: @movie.synopsis, title: @movie.title, user_id: @movie.user_id }
    end

    assert_redirected_to movie_path(assigns(:movie))
  end

  test "should show movie" do
    get :show, id: @movie
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @movie
    assert_response :success
  end

  test "should update movie" do
    patch :update, id: @movie, movie: { director: @movie.director, genre: @movie.genre, hotness: @movie.hotness, image_url: @movie.image_url, rating: @movie.rating, runtime: @movie.runtime, synopsis: @movie.synopsis, title: @movie.title, user_id: @movie.user_id }
    assert_redirected_to movie_path(assigns(:movie))
  end

  test "should destroy movie" do
    assert_difference('Movie.count', -1) do
      delete :destroy, id: @movie
    end

    assert_redirected_to movies_path
  end
end
