class UsersController < ApplicationController
    def show
        @user = User.find_by(:id => params[:id])
        @users = User.all
    end
end
