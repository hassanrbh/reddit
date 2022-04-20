module ApplicationHelper
    def avatar_url(user)
        if user.avatar.attached?
            url_for(user.avatar)
        elsif user.image?
            user.image
        else
            ActionController::Base.helpers.asset_path('hello.png')
        end
    end
end
