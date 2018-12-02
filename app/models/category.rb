class Category < ApplicationRecord
    validates :department,  :presence => true
    validates :name, :presence => true, :uniqueness => true
end
