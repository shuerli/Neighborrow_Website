class AccountMailer < ActionMailer::Base
    default from: 'sixneighborrow@gmail.com'
    
    def registration_confirmation(account)
        @account = account
        mail(to: "#{account.email} <#{account.email}>", subject:"Registration Confirmation")
    end
    
    def password_reset(account)
        @account = account
          mail(to: "#{account.email} <#{account.email}>", subject:"Password Reset")
    end
end
