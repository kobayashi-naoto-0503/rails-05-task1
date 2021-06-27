class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :photo, ImageUploader
end
