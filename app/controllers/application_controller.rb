class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    after_action :update_user_online!, if: :user_signed_in?


    def after_sign_out_path_for(resource)
        login_path
    end

    private
    def update_user_online!
        current_user.try :touch
    end
end
