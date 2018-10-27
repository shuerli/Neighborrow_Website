class Address < ApplicationRecord
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :address_line1, :city, :province, :country, :postal_code, :presence => true
    belongs_to :account
end
