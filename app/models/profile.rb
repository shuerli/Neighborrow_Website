class Profile < ApplicationRecord
    validates :email, :display_name, :presence => true
    has_one_attached :avatar
#    validate :avatar_picture_format
    after_commit :add_default_avatar, on: [:create, :update]
    
    private def avatar_picture_format
      return unless avatar.attached?
      return if avatar.blob.content_type.start_with? 'image/'
      avatar.purge_later
      errors.add(:avatar, 'needs to be an image')
      add_default_avatar_force
    end
    
    private def add_default_avatar
      unless self.avatar.attached?
        self.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "avatar.jpg")), filename: 'avatar.jpg' , content_type: "image/jpg")
      end
    end
    
#    private def add_default_avatar_force
#       self.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "avatar.jpg")), filename: 'avatar.jpg' , content_type: "image/jpg")
#    end
    # validates doesn't work right now:
#    validates :avatar, blob: { content_type: :image } # supported options: :image, :audio, :video, :text
#    validates :avatar, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }
    
#    validates :avatar, file_size: { less_than_or_equal_to: 100.kilobytes },
#                       file_content_type: { allow: ['image/jpeg', 'image/png'] }
#    validate :avatar_validation
#    
#    def avatar_validation
#      if avatar.attached?
#        if avatar.blob.byte_size > 1000000
#          avatar.purge
#          errors[:base] << 'Too big'
#          add_default_avatar_force
#        elsif !avatar.blob.content_type.starts_with?('image/')
#          logo.purge
#          errors[:base] << 'Wrong format'
#          add_default_avatar_force
#        end
#      end
#    end
    
  

end
