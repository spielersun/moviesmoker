class StaticPagesController < ApplicationController
    def home
        # @micropost = current_user.microposts.build if logged_in?
        if logged_in?
            @micropost  = current_user.microposts.build
            @feed_items = current_user.feed.paginate(page: params[:page])
            @wishlst_feed = current_user.moviefeed_wishlst_following
            @watched_feed = current_user.moviefeed_watched_following
            @bnndlst_feed = current_user.moviefeed_bnndlst_following
        end
    end

    def help
    end
    
    def about
    end
    def movies_all
        if logged_in?
            @movie = Movie.all
        else
            redirect_to root_url
        end
    end
end
