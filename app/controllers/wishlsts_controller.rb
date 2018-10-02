class WishlstsController < ApplicationController
    def index
        @movie = current_user.moviefeed_wishlst
    end
    
    def create
        @movie = Movie.find(params[:movie_id])
        @wishlst = @movie.wishlsts.create(user_id: current_user.id,
            add_date: Time.zone.now)
        redirect_to movie_path(@movie)
    end
    def destroy
        @movie = Movie.find(params[:movie_id])
        @wishlst = @movie.wishlsts.find(params[:id])
        @wishlst.destroy
        redirect_to movie_path(@movie)
    end
end
