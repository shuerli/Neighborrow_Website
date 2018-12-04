class Pickupaddress < ApplicationRecord
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :address_line1, :city, :province, :country, :postal_code, :presence => true
end
