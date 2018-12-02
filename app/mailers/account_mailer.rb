class AccountMailer < ActionMailer::Base
    default from: 'sixneighborrow@gmail.com'
    
    def registration_confirmation(account)
        @account = account
        mail(to: "#{account.email} <#{account.email}>", subject:"Neighborrow: Registration Confirmation")
    end
    
    def password_reset(account)
        @account = account
          mail(to: "#{account.email} <#{account.email}>", subject:"Neighborrow: Password Reset")
    end
    
    def status_update(account)
        @account = account
        mail(to: "#{account.email} <#{account.email}>", subject:"Neighborrow: Status Update")
    end
end
