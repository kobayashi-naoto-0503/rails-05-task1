class ImageFile < ApplicationRecord
  belongs_to :topics,optional: true
  mount_uploader :images, ImageUploader
end
