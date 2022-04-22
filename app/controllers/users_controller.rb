class UsersController < ApplicationController
    def show
        @user = User.friendly.find(params[:id])

        if params[:id] != @user.slug
            return redirect_to @user, :status => :moved_permanently
        end
        @users = User.all
    end
end
