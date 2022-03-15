class SessionsController < ApplicationController

    helper_method :current_user, :logged_in?

    def new
        @user = User.new
    end

    def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])

        if @user
            login_user!(@user)
            redirect_to user_url(@user)
        else
            render :new
        end
    end

    def destroy
        current_user.reset_session_token!
        session[:session_token] = nil
        @current_user = nil
        render :new
    end

end