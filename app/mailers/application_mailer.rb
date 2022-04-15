class ApplicationMailer < ActionMailer::Base
  default from: "from@reddit.com"
  layout "mailer"
end
