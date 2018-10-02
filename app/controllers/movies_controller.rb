class MoviesController < ApplicationController
    
    # http_basic_authenticate_with name: "sun", password: "123", except: [:index, :show]
    
    def index
        # @movie = Movie.all
        # @wishlst  = current_user.wishlsts.build
        
        if logged_in?
            
            @reccs = []
            @movie = current_user.moviefeed
            
            @watched = current_user.moviefeed_watched
            @wishlst = current_user.moviefeed_wishlst
            @bnndlst = current_user.moviefeed_bnndlst
            
            @movie.each do |movie|
                
                # RECOMMENDATION SCORE BASED ON USERS FAVOURITE TAGS
                tag_score = 1
                movie_tags = movie.genres.split(",")
                user_tags = current_user.fav_tags.split(",")
                
                movie_tags.each do |m|
                    user_tags.each do |u|
                        if m == u
                            tag_score = tag_score * 0.1
                        end
                    end
                end
                
                mood_fast = ((current_user.fav_mood_fast - movie.mood_fast).abs / 10).round
                if mood_fast == 0
                    mood_fast = 0.1
                end
                    
                mood_imaginary = ((current_user.fav_mood_imaginary - movie.mood_imaginary).abs / 10).round
                if mood_imaginary == 0
                    mood_imaginary = 0.1
                end
                
                mood_colored = ((current_user.fav_mood_colored - movie.mood_colored).abs / 10).round
                if mood_colored == 0
                    mood_colored = 0.1
                end
                
                mood_comedy = ((current_user.fav_mood_comedy - movie.mood_comedy).abs / 10).round
                if mood_comedy == 0
                    mood_comedy = 0.1
                end
                
                mood_intelligent = ((current_user.fav_mood_intelligent - movie.mood_intelligent).abs / 10).round
                if mood_intelligent == 0
                    mood_intelligent = 0.1
                end
                
                mood_ambient = ((current_user.fav_mood_ambient - movie.mood_ambient).abs / 10).round
                if mood_ambient == 0
                    mood_ambient = 0.1
                end
                
                mood_diverse = ((current_user.fav_mood_diverse - movie.mood_diverse).abs / 10).round
                if mood_diverse == 0
                    mood_diverse = 0.1
                end
                
                mood_wibbly = ((current_user.fav_mood_wibbly - movie.mood_wibbly).abs / 10).round
                if mood_wibbly == 0
                    mood_wibbly = 0.1
                end
                
                mood_talky = ((current_user.fav_mood_talky - movie.mood_talky).abs / 10).round
                if mood_talky == 0
                    mood_talky = 0.1
                end
                
                mood_known = ((current_user.fav_mood_known - movie.mood_known).abs / 10).round
                if mood_known == 0
                    mood_known = 0.1
                end
                
                mood_characteristic = ((current_user.fav_mood_characteristic - movie.mood_fast).abs / 10).round
                if mood_characteristic == 0
                    mood_characteristic = 0.1
                end
                
                # RECOMMENDATION SCORE BASED ON USERS FAVOURITE MOODS
                mood_total = mood_fast * mood_imaginary * mood_colored * mood_comedy * mood_intelligent * mood_ambient * mood_diverse * mood_wibbly * mood_talky * mood_known * mood_characteristic
                
                recc_total = mood_total * tag_score
                recc_total = recc_total.round
                
                #if recc_total <= 200
                #    @reccs << {:id => movie.id, :score => recc_total}
                #end
                
                
                
                # SPECIFY THE CUSTOM PLACEMENT
                plcment = "noplace"
                
                @watched.each do |watched|
                    if watched.id == movie.id
                        plcment = "watched"
                    end
                end
                
                @wishlst.each do |wishlst|
                    if wishlst.id == movie.id
                        plcment = "wishlst"
                    end
                end
                
                @bnndlst.each do |bnndlst|
                    if bnndlst.id == movie.id
                        plcment = "bnndlst"
                    end
                end
                
                # GET RECOMMENDATIONS AND SORT BY THEIR TOTAL SCORE
                @reccs << {:id => movie.id, :score => recc_total, :plcment => plcment}
                @reccs = @reccs.sort_by{|e| e[:score]}
            end
        end
    end
    
    def show
        @movie = Movie.find(params[:id])
    end
    
    def new
        @movie = Movie.new
    end
    
    def edit
        @movie = Movie.find(params[:id])
    end
        
    def create
        #render plain: params[:movie].inspect
        @movie = Movie.new(movie_params)
        if @movie.save
            redirect_to @movie
        else
            render 'new'
        end
    end
    
    def update
        @movie = Movie.find(params[:id])
        
        if @movie.update(movie_params)
            redirect_to @movie
        else
            render 'edit'
        end
    end
    
    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        
        redirect_to movies_path
    end
    
    private
        def movie_params
            params.require(:movie).permit(:name, :year, :imdb, :genres, :cover_image, :mood_fast, :mood_imaginary, :mood_colored, :mood_comedy, :mood_intelligent, :mood_ambient, :mood_diverse, :mood_wibbly, :mood_talky, :mood_known, :mood_characteristic, :env_group, :env_theater, :env_consume, :personal_age, :personal_gender)
        end
end


