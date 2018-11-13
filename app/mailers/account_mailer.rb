class AccountMailer < ActionMailer::Base
    default from: 'qingqing.zhuo@mail.utoronto.ca'
    
    def registration_confirmation(account)
        @account = account
        mail(to: "#{account.email} <#{account.email}>", subject:"Registration Confirmation")
    end
    
end
