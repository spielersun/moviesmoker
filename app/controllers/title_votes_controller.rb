class TitleVotesController < ApplicationController
    
    # http_basic_authenticate_with name: "sun", password: "123", only: :destroy
    
    def create
        @movie = Movie.find(params[:movie_id])
        
        vote_params = {:commenter => current_user.id}
        vote_params[:vote] = title_vote_params[:vote]
        @title_vote = @movie.title_votes.create(vote_params)
        
        @voted_movies = current_user.moviefeed_voteds
        movie_count = @voted_movies.length
        
        if movie_count % 20 == 0
            
            # Update Favourite Mood

            total_mood_fast = 0
            total_mood_imaginary = 0
            total_mood_colored = 0
            total_mood_comedy = 0
            total_mood_intelligent = 0
            total_mood_ambient = 0
            total_mood_diverse = 0
            total_mood_wibbly = 0
            total_mood_talky = 0
            total_mood_known = 0
            total_mood_characteristic = 0
            
            @voted_movies.each do |m|
                movie_vote = TitleVote.where(:commenter => current_user.id, :movie_id => m.id).first.vote
                
                fav_mood_fast_before = m.mood_fast
                fav_mood_imaginary_before = m.mood_imaginary
                fav_mood_colored_before = m.mood_colored
                fav_mood_comedy_before = m.mood_comedy
                fav_mood_intelligent_before = m.mood_intelligent
                fav_mood_ambient_before = m.mood_ambient
                fav_mood_diverse_before = m.mood_diverse
                fav_mood_wibbly_before = m.mood_wibbly
                fav_mood_talky_before = m.mood_talky
                fav_mood_known_before = m.mood_known
                fav_mood_characteristic_before = m.mood_characteristic
                
                total_mood_fast += (movie_vote * fav_mood_fast_before)
                total_mood_imaginary += (movie_vote * fav_mood_imaginary_before)
                total_mood_colored += (movie_vote * fav_mood_colored_before)
                total_mood_comedy += (movie_vote * fav_mood_comedy_before)
                total_mood_intelligent += (movie_vote * fav_mood_intelligent_before)
                total_mood_ambient += (movie_vote * fav_mood_ambient_before)
                total_mood_diverse += (movie_vote * fav_mood_diverse_before)
                total_mood_wibbly += (movie_vote * fav_mood_wibbly_before)
                total_mood_talky += (movie_vote * fav_mood_talky_before)
                total_mood_known += (movie_vote * fav_mood_known_before)
                total_mood_characteristic += (movie_vote * fav_mood_characteristic_before)
            end

            fav_mood_fast_after = (total_mood_fast / (movie_count * 10)).round
            fav_mood_imaginary_after = (total_mood_imaginary / (movie_count * 10)).round
            fav_mood_colored_after = (total_mood_colored / (movie_count * 10)).round
            fav_mood_comedy_after = (total_mood_comedy / (movie_count * 10)).round
            fav_mood_intelligent_after = (total_mood_intelligent / (movie_count * 10)).round
            fav_mood_ambient_after = (total_mood_ambient / (movie_count * 10)).round
            fav_mood_diverse_after = (total_mood_diverse / (movie_count * 10)).round
            fav_mood_wibbly_after = (total_mood_wibbly / (movie_count * 10)).round
            fav_mood_talky_after = (total_mood_talky / (movie_count * 10)).round
            fav_mood_known_after = (total_mood_known / (movie_count * 10)).round
            fav_mood_characteristic_after = (total_mood_characteristic / (movie_count * 10)).round
            
            new_favs = {
                :fav_mood_fast => fav_mood_fast_after, 
                :fav_mood_imaginary => fav_mood_imaginary_after, 
                :fav_mood_colored => fav_mood_colored_after, 
                :fav_mood_comedy => fav_mood_comedy_after, 
                :fav_mood_intelligent => fav_mood_intelligent_after, 
                :fav_mood_ambient => fav_mood_ambient_after, 
                :fav_mood_diverse => fav_mood_diverse_after, 
                :fav_mood_wibbly => fav_mood_wibbly_after, 
                :fav_mood_talky => fav_mood_talky_after, 
                :fav_mood_known => fav_mood_known_after, 
                :fav_mood_characteristic => fav_mood_characteristic_after
                }
            
            @user = User.find(current_user.id)
            
            @user.update_attributes(new_favs)
        
            flash[:info] = "Your Moods Updated"
            
            
            
        else
            flash[:info] = "You don't have enough votes to build your mood profile."
        end
        
        redirect_to movie_path(@movie)
    end
    
    def destroy
        @movie = Movie.find(params[:movie_id])
        @title_vote = @movie.title_votes.find(params[:id])
        @title_vote.destroy
        redirect_to movie_path(@movie)
    end
    
    private
        def title_vote_params
            params.require(:title_vote).permit(:vote)
        end
end