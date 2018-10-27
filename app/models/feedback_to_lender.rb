class FeedbackToLender < ApplicationRecord
    validates :requiest_id, :rate, :credit, :presence => true
end
