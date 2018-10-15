class Account < ApplicationRecord
	ROLE_OPTIONS = %w(user admin)
	STATUS_OPTIONS = %w(created active suspended banned)

	validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
	validates :role, presence: true, :inclusion => {:in => ROLE_OPTIONS}
	validates :status, presence: true, :inclusion => {:in => STATUS_OPTIONS}
	validates :password, :salt, :presence => true
end
