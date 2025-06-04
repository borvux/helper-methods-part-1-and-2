class MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end

  def index
    @movies = Movie.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html
    end
  end

  def show
    @movie = Movie.find(params.fetch(:id)) # @movie = Movie.find_by(id: params.fetch(:id)) # @movie = Movie.where(id: params.fetch(:id)).first
  end

  def create
    movie_attributes = params.require(:movie).permit(:title, :description)
    @movie = Movie.new(movie_attributes)

    # @movie = Movie.new
    # @movie.title = params.fetch(:title)
    # @movie.description = params.fetch(:description)

    if @movie.valid?
      @movie.save
      redirect_to movies_url, { notice: "Movie was successfully created." } # we should only use paths on the client facing view templates. But, when we’re sending responses back, we should use the fully qualified URL, including the domain name.
    else
      render "movies/new"
    end
  end

  def edit
    @movie = Movie.find(params.fetch(:id))
  end

  def update
    @movie = Movie.find(params.fetch(:id))
    movie_attributes = params.require(:movie).permit(:title, :description)

    # movie.title = params.fetch(:title)
    # movie.description = params.fetch(:description)

    if @movie.update(movie_attributes)
      @movie.save
      redirect_to movie_url(@movie), { notice: "Movie updated successfully." }
    else
      redirect_to movie_url(@movie), { alert: "Movie failed to update successfully." }
    end
  end

  def destroy
    movie = Movie.find(params.fetch(:id))

    movie.destroy

    redirect_to movies_url, { notice: "Movie deleted successfully." }
  end
end
