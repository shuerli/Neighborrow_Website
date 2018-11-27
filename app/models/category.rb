class Category < ApplicationRecord
    validates :department, :name, :presence => true
end
