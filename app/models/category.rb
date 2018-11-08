class Category < ApplicationRecord
    validates :department, :name, :presence => true
    has_many :items
end
