class Item < ApplicationRecord
    validates :owner, :condition, :time_start, :time_end, :time_pickup, :name, :description, :presence => true
    belongs_to :category
end
