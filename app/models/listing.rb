class Listing < ApplicationRecord
  include PgSearch
  include Filterable


  belongs_to :user
  has_many :reservations, dependent: :destroy

  # pg_search_scope :search_by_property_title, :against => [:property_title]
  # malaysia
  pg_search_scope :search_by_listings,
                  :against => [:property_title, :location],
                  :using => {
                    :tsearch => {:prefix => true}
                  }

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
  validates :photos, presence: true
  # validates :photos, presence: true
# scopingA
  scope :property_title, -> (property_title) { where property_title: property_title }
  scope :location, -> (location) { where location: location }


  # pg_search_scope :search_by_title, :against => :title

end
