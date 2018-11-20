require 'digest/sha1'

class Account < ApplicationRecord
    ROLE_OPTIONS = %w(user admin)
    STATUS_OPTIONS = %w(created active suspended banned)
    
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :role, presence: true, :inclusion => {:in => ROLE_OPTIONS}
    validates :status, presence: true, :inclusion => {:in => STATUS_OPTIONS}
    validates :password, presence: true, confirmation:true, length: { minimum: 5 }
    
    has_many :addresses

    before_save :encrypt_password
    before_validation :assign_role, on: :create
    before_validation :assign_status, on: :create
    before_create :confirmation_token

    
    ###################### USED FOR SIGN IN ######################
    
    def encrypt_password
        if password.present?
            self.salt = 1
            
        end
    end

    
    #FIXME temporarily make all accounts "ROLE = user"
    def assign_role
        self.role = "user"
    end
    
    #Upon creation, all accounts default to have "status = created"
    def assign_status
        self.status = "created"
    end
    
    
    ###################### USED FOR LOGIN(AUTHENTICATION)######################
    def match_password(login_password = "")
        password == login_password
    end
    
    def authenticate(email = "", login_password = "")
        account = Account.find_by_email(email)
        
        if account && account.match_password(login_password)
            return account
            
            else
            return nil
        end
    end
    
    #used for email verification#
    
    def email_activate
        self.email_confirmed = true
        self.confirm_token = nil
        save!(:validate => false)
    end
    
    private
    def confirmation_token
        if self.confirm_token.blank?
            self.confirm_token = SecureRandom.urlsafe_base64.to_s
        end
    end
end
