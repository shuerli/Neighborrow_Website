require 'digest/sha1'

class Account < ApplicationRecord
    ROLE_OPTIONS = %w(user admin)
    STATUS_OPTIONS = %w(created active suspended banned)
    
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :role, presence: true, :inclusion => {:in => ROLE_OPTIONS}
    validates :status, presence: true, :inclusion => {:in => STATUS_OPTIONS}
    validates :password, presence: true, confirmation:true, length: { minimum: 5 }
    
    has_many :addresses
    before_create :encrypt_password
    before_create :confirmation_token
    before_validation :assign_role, on: :create
    before_validation :assign_status, on: :create

    
    ###################### USED FOR SIGN IN ######################
    
    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |account|
            account.provider = auth.provider
            account.uid = auth.uid
            account.name = auth.info.name
            account.email = auth.info.email
            account.password = 'tempPasswordForNow'
            account.oauth_token = auth.credentials.token
            account.oauth_expires_at = Time.at(auth.credentials.expires_at)
            account.save!
        end
    end


    def encrypt_password
        if password.present?
            self.salt = BCrypt::Engine.generate_salt
            self.password = BCrypt::Engine.hash_secret(self.password, self.salt)
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
        password == BCrypt::Engine.hash_secret(login_password, salt)
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
