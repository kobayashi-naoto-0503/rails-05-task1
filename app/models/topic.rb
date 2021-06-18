class Topic < ApplicationRecord
  validates :user_id, presence: true
  validates :description, presence: true
  
  belongs_to :user
  
  mount_uploader :image, ImageUploader
  
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: 'user'
  has_many :comments, dependent: :destroy
  has_many :image_files,dependent: :destroy
  accepts_nested_attributes_for :image_files,allow_destroy: true
  
end
