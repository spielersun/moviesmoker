class BnndlstsController < ApplicationController
    def index
        @movie = current_user.moviefeed_bnndlst
    end
    
    def create
        @movie = Movie.find(params[:movie_id])
        @bnndlst = @movie.bnndlsts.create(user_id: current_user.id,
            add_time: Time.zone.now)
        redirect_to movie_path(@movie)
    end
    def destroy
        @movie = Movie.find(params[:movie_id])
        @bnndlst = @movie.bnndlsts.find(params[:id])
        @bnndlst.destroy
        redirect_to movie_path(@movie)
    end
end
