class Profile < ApplicationRecord
    validates :email, :display_name, :presence => true
    has_one_attached :avatar
    after_commit :add_default_avatar, on: [:create, :update]
    
    private def avatar_picture_format
      return unless avatar.attached?
      return if avatar.blob.content_type.start_with? 'image/'
      avatar.purge_later
      errors.add(:avatar, 'needs to be an image')
      add_default_avatar_force
    end
    
    private def add_default_avatar
      unless avatar.attached?
        self.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "avatar.jpg")), filename: 'avatar.jpg' , content_type: "image/jpg")
      end
    end
    # validates doesn't work right now:
    validates :avatar, blob: { content_type: :image } # supported options: :image, :audio, :video, :text
   
end
