<img src="https://github.com/spielersun/moviesmoker/blob/master/ms-interest.png" title="expand" style="width:32px;height:32px;"/>

# moviesmoker

## personalized movie lists based on three categories: wished, watched, banned.

*I am adding movies to the system with these parameters with 1-100 scaling.*

### Moods
Speed: Slow - Fast
Imagination: Real world - Imaginary
Colors: Dark/Cold - Colored/Happy
Type: Drama - Comedy
Mind Bending: Straight - Puzzly
Focus: Person - Ambient
Complexity: Stable - Diverse
Time: Linear - Wibbly Wobbly
Talky: Watch - Listen
Recognition: Underground - Known
Authenticity: Common - Authentic

*I specify these attributes at start, but the system will adjust these values by every 100 vote per movie.*

### Environmental Preferences
Alone/With someone
Home/Theater, 
Consume food/drink

*At start these will be blank, they will updated by the watchers own preferences.*

### Personal Information
Age
Gender

*At start these will be blank, they will updated by the watchers own preferences.*

### Tags
Action, adventure, animation, comedy, crime, documentary, drama, fantasy, historical, horror, musical, romantic, sci-fi, thriller, alien, animal, biography, concert, disaster, dystopia, family, fugitive, genius, mafia, mental illness, music, mystery, novel, politics, racing, racism, revenge, roadtrip, serail killer, sport, superhero, time travel, true stroy, vampire, war, western, zombie, desert, high school, island, jungle, mountain, office, prison, room, water, small town, space, suburban, underground, university, prehistoric, ancient ages, middle ages, 1800s, World War I, World War 2, Civil War, Cold War, 60s, 70s, 80s, 90s, 00s, today, future, apocalyptic, post apocalyptic, africa, Asia, Europe, North America, Ocenia, South America, Antarctica, Moon, Mars, Orbit, Outer Solar System.

*Genres will be here too, there could be many (average: 3,4) and will be added in the future.*

Every user in the system will start with these attributes too as their favourite moods, environmental settings. When a user sign up to system, he/she can’t specify the moods he/she like. But every 20 movies a person liked, his/her mood, environmental settings will be updated. But at start user should add some tags he/she may like, this will be used as a initial value. These tags will be updated every 20 movies a person liked too. 

### Recommendation Algorithm
####Recommendation score based on the favourite tags of the user.

Get the tags of the movie and favourite tags of the user
```ruby
tag_score = 1
movie_tags = movie.genres.split(",")
user_tags = current_user.fav_tags.split(",")
```

For every matched tag update the tag score
```ruby
movie_tags.each do |m|
   user_tags.each do |u|
      if m == u
         tag_score = tag_score * 0.1
      end
   end
end
```

Substitute mood of the user from mood of the movie, take the absolute value divide by ten.
If mood of the user matches with mood of the movie, divide the total by 10 since scale is 1-10
```ruby
mood_fast = ((current_user.fav_mood_fast - movie.mood_fast).abs / 10).round
if mood_fast == 0
   mood_fast = 0.1
end
```

*Recommendation score based on the mood scores and tag score.*

Multiply all of the constants to get close to 0

```ruby
mood_total = mood_fast * mood_imaginary * mood_colored * mood_comedy * mood_intelligent * mood_ambient * mood_diverse * mood_wibbly * mood_talky * mood_known * mood_characteristic
                
recc_total = mood_total * tag_score
recc_total = recc_total.round
```

Find the situation of the movie for that user, if he/she watched, wished or banned that movie.
```ruby
plcment = "noplace"
@watched.each do |watched|
   if watched.id == movie.id
      plcment = "watched"
   end
end
```

Get movies and sort them by their total recommendation scores
```ruby
@reccs << {:id => movie.id, :score => recc_total, :plcment => plcment}
@reccs = @reccs.sort_by{|e| e[:score]}
```

*This is the movies view. It filled with recommendations, for every movie it gets name (by movie[:id]), url of the movie(movie_path(movie)), the placement (no placement, wished, watched, banned) and cover image if there is one.* 

```html
<ul class="ms_section_movies">
    <% @reccs.each do |movie| %>
    <li class="col-md-4">
        <span class="<%= movie[:plcment] %>"></span>
        <%= image_tag "movies/big/" + (Movie.find(movie[:id])).cover_image if (Movie.find(movie[:id])).cover_image? %>
        <%= link_to (Movie.find(movie[:id])).name, movie_path(movie) %>
    </li>
    <% end %>
</ul>
```

### Update User Attributes Algorithm
*Update the moods of a user in every 20 movies he/she voted.*

Get the movie count
```ruby
@voted_movies = current_user.moviefeed_voteds
movie_count = @voted_movies.length
```

If count is 20 or its multitudes begin 
```ruby
if movie_count % 20 == 0
total_mood_fast = 0
```

Get the every vote of the movies he/she voted
```ruby
@voted_movies.each do |m|
movie_vote = TitleVote.where(:commenter => current_user.id, :movie_id => m.id).first.vote
```

Get the movie mood, for every mood type
```ruby
mood_fast = movie.mood_fast
```
             
Multiply with the initial vote and add them together
```ruby
total_mood_fast += (movie_vote * mood_fast)
end
```

Divide the total number with the movie count
```ruby
fav_mood_fast = (total_mood_fast / (movie_count * 10)).round
```

Put the new values to a hash
```ruby
new_favs = { :fav_mood_fast => fav_mood_fast_after, }
```

Update the users information in the database
```ruby
@user = User.find(current_user.id)
@user.update_attributes(new_favs)
```

Update the user about the situation
```ruby
flash[:info] = "Your Moods Updated"
```

## WATCH, WISH, BAN

A user in the system can specify the movies as “watched”, “wish to watch” and “do not want to watch”. These are the main interactive features of the system. These movies will be added and can be seen from the navigation bar. There will be icons in the recommended movie list that indicates what place do you put a movie. Also there is “watched”, “wishlst” and “bnndlst” sections in the homepage for the users you followed. 

*This is how the system gets the wishlist of a user, get wished movies from wishlist table by that user and call them from the movies table.*

```ruby
def moviefeed_wishlst
   movie_ids = "SELECT movie_id FROM wishlsts WHERE  user_id = :user_id"
   Movie.where("id IN (#{movie_ids})", user_id: id)
end
```

*This is how the system gets the wishlist of the following users, get the following users of the user and call them from the wishlist table for what they are wished to see.*

```ruby
def moviefeed_wishlst_following
   following_ids = "SELECT followed_id FROM relationships WHERE  follower_id = :user_id"
   Wishlst.where("user_id IN (#{following_ids})", user_id: id)
end
```

*This gets user’s wishlist and print the results for the wishlist page. As you can see the system uses user id from wishlist table to find the user and movie id from the wishlist table again to find the movie.*

```ruby
<% @wishlst_feed.each do |feed| %>
   <li>
      <span class="following_feed_name"><%= User.find(feed.user_id).name %></span>
      <span class="following_feed_movie"><%= Movie.find(feed.movie_id).name %></span>
      <span class="following_feed_date"><%= feed.add_date.to_formatted_s(:short) %></span>
   </li>
<% end %>
```


## SOCIAL SIDE

There is a twitter-like section in the system to see who commented about what. A user can follow a or followed by a user to see his/her posts and to monitor who “watched”, “wished” or “banned” which movie. The system does not use these elements to decide what to recommend to a user, but these will be valuable if someday I ll add them as a recommendation parameter.

Wall posts of the user and his/her followings, get people from relationships where follower id is equal to current logged in user id. Then get their and users posts from Micropost table.

```ruby
def feed
   following_ids = "SELECT followed_id FROM relationships WHERE  follower_id = :user_id"
   Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
End
```

*This is wall view, it gets any micropost for called procedure and show render them with pagination*

```ruby
<% if @user.microposts.any? %>
   <h3>WALL (<%= @user.microposts.count %>)</h3>
   <ol class="microposts"> <%= render @microposts %></ol>
   <%= will_paginate @microposts %>
<% end %>
```


## VOTING

For every watched movie the user will vote to that movie. This vote will be shown to all of the users to get an idea about the movie.

### Voted Movies

This is a basic html show block. This view gets the user id from title votes table and uses it for calling the name of the user.

```html
<li>
   <%= User.find(title_vote.commenter).name %> : <%= title_vote.vote %> | 
   <%= link_to 'X', [title_vote.movie, title_vote], method: :delete, data: { confirm: 'Are you sure?' } %>
</li>
```

*In the “watched” section, there is an indicator on the top-right side of the movie that shows the vote of the user.*

I thought that I should get every possible information and opinion about the movies from the user. For these kind of stuff I designed a multi-dimensional voting system. But that will be in an another project. 
