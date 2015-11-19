# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    if params[:sort] == "title" then 
      @movies = Movie.order("title") #Project 4.3.3
    elsif params[:sort] == "rating" then
      @movies = Movie.order("rating")
    elsif params[:sort] == "date" then
      @movies = Movie.order("release_date")
    else
      @movies = Movie.all
    end
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.html.haml by default
  end

#  def new
    # default: render 'new' template
#  end

#  def create
#    @movie = Movie.create!(params[:movie])
#    flash[:notice] = "#{@movie.title} was successfully created."
#    redirect_to movies_path
#  end

  def edit
    @movie = Movie.find params[:id]
  end

#  def update
#    @movie = Movie.find params[:id]
#    @movie.update_attributes!(params[:movie])
#    flash[:notice] = "#{@movie.title} was successfully updated."
    #redirect_to movie_path(@movie)
#    respond_to do |client_wants|
#      client_wants.html {  redirect_to movie_path(@movie)  } # as before
#      client_wants.xml  {  render :xml => @movie.to_xml    }
#    end
#  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  # replaces the 'create' method in controller:
  def create
    @movie = Movie.new(params[:movie])
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    else
      render 'new' # note, 'new' template can access @movie's field values!
    end
  end
  # replaces the 'update' method in controller:
  def update
    @movie = Movie.find params[:id]
    if @movie.update_attributes(params[:movie])
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    else
      render 'edit' # note, 'edit' template can access @movie's field values!
    end
  end
  # as a reminder, here is the original 'new' method:
  def new
    @movie = Movie.new
  end
end
