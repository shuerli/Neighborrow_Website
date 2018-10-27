class Item < ApplicationRecord
    validates :owner, :condition, :category, :time_start, :time_end, :time_pickup, :name, :description, :presence => true
end
