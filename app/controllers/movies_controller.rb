class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :scrape, only: [:new]

  def index
    @movies = current_user.movies
  end

  def show
  end

  def new
    @movie = Movie.new
    if @movie_data.failure == nil
      @movie = Movie.new(
        title: @movie_data.title,
        hotness: @movie_data.hotness,
        image_url: @movie_data.image_url,
        synopsis: @movie_data.synopsis,
        rating: @movie_data.rating,
        genre: @movie_data.genre,
        director: @movie_data.director,
        runtime: @movie_data.runtime
        )
    else
      @movie = Movie.new
      if params[:search]
        @failure = @movie_data.failure
      end
    end
  end

  def edit
  end

  def create
    @movie = current_user.movies.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :hotness, :image_url, :synopsis, :rating, :genre, :director, :runtime, :user_id)
    end

    def scrape
      @movie_data = UrlScraper.new.scrape_new_movie(params[:search].to_s)
    end
end
