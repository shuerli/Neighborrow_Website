class FeedbackToBorrower < ApplicationRecord
    validates :request_id, :rate, :credit, :presence => true     
end
