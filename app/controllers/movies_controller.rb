class MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end

  def index
    # matching_movies = Movie.all
    # @list_of_movies = matching_movies.order(created_at: :desc)
    @movies = Movie.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @movies
      end
      format.html
    end
  end

  def show
    # the_id = params.fetch(:id)
    # matching_movies = Movie.where(id: the_id)
    # @the_movie = matching_movies.first

    @movie = Movie.find(params.fetch(:id))
  end

  def create
    movie_attributes = params.require(:movie).permit(:title, :description)

    @movie = Movie.new(movie_attributes)
    # @movie.title = params.fetch(:movie).fetch(:title)
    # @movie.description = params.fetch(:movie).fetch(:description)

    if @movie.valid?
      @movie.save
      redirect_to movies_url, notice: "Movie created successfully."
    else
      render "new"
    end
  end

  def edit
    # the_id = params.fetch(:id)
    # matching_movies = Movie.where(id: the_id)
    # @the_movie = matching_movies.first
    @movie = Movie.find(params.fetch(:id))
  end

  def update
    # the_id = params.fetch(:id)
    # the_movie = Movie.where(id: => the_id).first
    # movie = Movie.find(params.fetch(:id))

    # movie.title = params.fetch(:movie).fetch(:title)
    # movie.description = params.fetch(:movie).fetch(:description)

    movie_attributes = params.require(:movie).permit(:title, :description)

    movie = Movie.new(movie_attributes)

    if movie.valid?
      movie.save
      redirect_to movie_url(movie), notice: "Movie updated successfully."
    else
      redirect_to movie_url(movie), alert: "Movie failed to update successfully."
    end
  end

  def destroy
    # the_id = params.fetch(:id)
    # movie = Movie.where(id: the_id).first

    # movie.destroy

    movie = Movie.find(params.fetch(:id))
    movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
