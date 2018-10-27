class Chat < ApplicationRecord
    validates :time, :sender, :receiver, :content, :presence => true
end
