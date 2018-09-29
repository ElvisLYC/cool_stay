class Listing < ApplicationRecord

  belongs_to :user
  has_many :reservations
  include PgSearch
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
# scopingA
  scope :property_title, -> (property_title) { where property_title: property_title }
  scope :location, -> (location) { where location: location }

  pg_search_scope :search_by_title, :against => :title

end
