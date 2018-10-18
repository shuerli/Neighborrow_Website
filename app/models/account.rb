require 'digest/sha1'

class Account < ApplicationRecord
	ROLE_OPTIONS = %w(user admin)
	STATUS_OPTIONS = %w(created active suspended banned)

	validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
	validates :role, presence: true, :inclusion => {:in => ROLE_OPTIONS}
	validates :status, presence: true, :inclusion => {:in => STATUS_OPTIONS}
	validates :password, :salt, :presence => true
    
    before_validation :encrypt_password, on: :create
    before_validation :assign_role, on: :create
    before_validation :assign_status, on: :create
    
    def encrypt_password
        if password.present?
            self.salt = Digest::SHA1.hexdigest("#{email} and #{Time.now}")
            self.password = Digest::SHA1.hexdigest("#{salt}#{password}")
        end
    end
    
    #FIXME temporarily make all accounts "ROLE = user"
    def assign_role
        self.role = "user"
    end
    
    def assign_status
        self.status = "created"
    end
end
