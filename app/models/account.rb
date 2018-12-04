require 'digest/sha1'

class Account < ApplicationRecord
    ROLE_OPTIONS = %w(user admin)
    
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :role, presence: true, :inclusion => {:in => ROLE_OPTIONS}
    validates :password, presence: true, confirmation:true, length: { minimum: 5 }
    
    has_many :pickupaddresses
    before_create :encrypt_password
    before_create :confirmation_token
    before_validation :assign_role, on: :create
    before_validation :assign_status, on: :create
    attr_accessor :reset_token

    
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


    ###########################RESET PASSWORDS####################################
    def create_reset_digest
        self.reset_token = Account.new_token
        update_attribute(:reset_digest,  Account.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    #generate a random token
    def Account.new_token
        SecureRandom.urlsafe_base64
    end

    def Account.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def send_password_reset_email
        AccountMailer.password_reset(self).deliver_now
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    def password_reset_expired?
       reset_sent_at < 2.hours.ago
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
