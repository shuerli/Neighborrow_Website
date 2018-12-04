class Iten < ApplicationRecord
validates :owner, :condition, :time_start, :time_end, :name, :presence => true
end
