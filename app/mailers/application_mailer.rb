class ApplicationMailer < ActionMailer::Base
  default from: ENV['KEY1']
  layout 'mailer'
end
