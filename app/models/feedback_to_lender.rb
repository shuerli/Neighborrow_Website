class FeedbackToLender < ApplicationRecord
    validates :request_id, :rate, :credit, :presence => true
end
