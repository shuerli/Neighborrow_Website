class Profile < ApplicationRecord
    validates :email, :display_name, :presence => true
end
