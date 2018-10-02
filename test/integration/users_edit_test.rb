require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
    def setup
        @user = users(:michael)
    end

    test "unsuccessful edit" do
        log_in_as(@user)
        get edit_user_path(@user)
        assert_template 'users/edit'
        patch user_path(@user), user: { name:  "",
                                    mail: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar",
                                    score: 9 }
        assert_template 'users/edit'
    end
    
    test "successful edit with friendly forwarding" do
        # log_in_as(@user)
        # get edit_user_path(@user)
        # assert_template 'users/edit'
        get edit_user_path(@user)
        log_in_as(@user)
        assert_redirected_to edit_user_path(@user)
        
        name  = "Foo Bar"
        mail = "foo@bar.com"
        score = 10
        patch user_path(@user), user: { name:  name,
                    mail: mail, password: "",
                    password_confirmation: "", score: score }
        assert_not flash.empty?
        assert_redirected_to @user
        @user.reload
        assert_equal name,  @user.name
        assert_equal mail, @user.mail
        assert_equal score, @user.score
    end
end
