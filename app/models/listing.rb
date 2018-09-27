class Listing < ApplicationRecord
  belongs_to :user
  has_many :reservations

  mount_uploaders :photos, AvatarUploader


  validates :property_title, presence: true,
                  length: { minimum: 4 }
  validates :location, presence: true,
                  length: { minimum: 4 }
# input regex here
  validates :price, presence: true,
                  length: { minimum: 3 }
  validates :location, presence: true,
                  length: { minimum: 4 }
end
