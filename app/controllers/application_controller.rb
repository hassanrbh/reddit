class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    after_action :update_user_online!, if: :user_signed_in?
    before_action :configure_permitted_parameters,
        if: :devise_controller?
            protected

            def configure_permitted_parameters
                devise_parameter_sanitizer.permit(:sign_up,keys: [:avatar,:first_name,:last_name])
                devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
            end

    def after_sign_out_path_for(resource)
        login_path
    end

    private
    def update_user_online!
        current_user.try :touch
    end
end
