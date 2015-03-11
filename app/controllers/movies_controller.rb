class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if session[:ratings]==nil
      session[:ratings]= {'G' => 1,'PG' => 1,'PG-13' => 1, 'R' =>1 }
    end
    sort= params[:sort]

    @all_ratings=['G','PG','PG-13','R'] 

    @chosen_ratings=params[:ratings]
    if @chosen_ratings==nil
      @chosen_ratings = session[:ratings]
    end

    session[:ratings]=@chosen_ratings


    @movies= Movie.where(rating: @chosen_ratings.keys).order(sort)

    #debugger
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
