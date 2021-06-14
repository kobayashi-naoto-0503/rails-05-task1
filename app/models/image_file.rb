class ImageFile < ApplicationRecord
  belongs_to :topics
  mount_uploader :image, ImageUploader
end
