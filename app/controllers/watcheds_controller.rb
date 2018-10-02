class WatchedsController < ApplicationController
    def index
        @movie = current_user.moviefeed_watched
    end
    
    def create
        @movie = Movie.find(params[:movie_id])
        @watched = @movie.watcheds.create(user_id: current_user.id,
            add_date: Time.zone.now)
        redirect_to movie_path(@movie)
    end
    
    def destroy
        @movie = Movie.find(params[:movie_id])
        @watched = @movie.watcheds.find(params[:id])
        @watched.destroy
        redirect_to movie_path(@movie)
    end
end
