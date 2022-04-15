class UserMailer < ApplicationMailer
    default from: 'notification@reddit.com'
    
    def notify_sub(user,sub)
        @user = user
        @sub = sub
        @url = "https://localhost:3000/subs/#{@sub.id}"
        mail(to: @user.email, subject: "New Sub Created (#{@sub.title})")
    end

    def notify_sub_error
        # for error messages, toC
    end
    
    def notify_sub_update
        # updated successful sub
    end
    def notify_sub_update_error
        # error for updating the sub
    end
end
