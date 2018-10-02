class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update,  :destroy, :following, :followers]
    before_action :correct_user,   only: [:edit, :update]
    before_action :admin_user,     only: :destroy
    
    def index
        @users = User.paginate(page: params[:page])
    end
    
    def show
        @user = User.find(params[:id])
        @microposts = @user.microposts.paginate(page: params[:page])
    end
    
    def new
        @user = User.new
    end
    
    def edit
        @user = User.find(params[:id])
    end
        
    def create
        @user = User.new(user_params)
        if @user.save
            @user.send_activation_email
            # UserMailer.account_activation(@user).deliver_now
            flash[:info] = "Please check your email to activate your account."
            redirect_to root_url
        else
            render 'new'
        end
    end
    
    def update_favs(params)
        @user = User.find(current_user.id)
        @user.update_attributes(params)
        
        flash[:info] = "Your Moods Updated"
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = "Profile updated"
            redirect_to @user
        else
            render 'edit'
        end
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:success] = "User deleted"
        redirect_to users_path
    end
    
    def following
        @title = "Following"
        @user  = User.find(params[:id])
        @users = @user.following.paginate(page: params[:page])
        render 'show_follow'
    end

    def followers
        @title = "Followers"
        @user  = User.find(params[:id])
        @users = @user.followers.paginate(page: params[:page])
        render 'show_follow'
    end
    
    private
        def user_params
            params.require(:user).permit(:name, :mail, :password,
                            :password_confirmation, :score, :fav_mood_fast, :fav_mood_imaginary, :fav_mood_colored, :fav_mood_comedy, :fav_mood_intelligent, :fav_mood_ambient, :fav_mood_diverse, :fav_mood_wibbly, :fav_mood_talky, :fav_mood_known, :fav_mood_characteristic, :fav_env_group, :fav_env_theater, :fav_env_consume, :birthdate, :gender, :fav_tags)
        end
    
        # Confirms a logged-in user.
        def logged_in_user
            unless logged_in?
                store_location
                flash[:danger] = "Please log in."
                redirect_to login_url
            end
        end
            
        # Confirms the correct user.
        def correct_user
            @user = User.find(params[:id])
            # redirect_to(root_url) unless @user == current_user
            redirect_to(root_url) unless current_user?(@user)
        end
    
        # Confirms an admin user.
        def admin_user
            redirect_to(root_url) unless current_user.admin?
        end
end
