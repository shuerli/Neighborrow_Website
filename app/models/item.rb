class Item < ApplicationRecord
validates :owner, :condition, :time_start, :time_end, :name, :description, :presence => true
end
