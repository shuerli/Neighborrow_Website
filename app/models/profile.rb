class Profile < ApplicationRecord
    validates :email, :display_name, :presence => true
    has_one_attached :avatar
    
    # validates doesn't work right now:
    validates :avatar, blob: { content_type: :image } # supported options: :image, :audio, :video, :text
   
end
