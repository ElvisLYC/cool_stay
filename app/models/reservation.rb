class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :reserved_date, if: -> { start_date && end_date }
  validate :check_dates, if: -> { start_date && end_date }

  # test scoping for filtering
  scope :property_title, -> (property_title) { where property_title: property_title }
  scope :location, -> (location) { where location: location }
  # scope :state, -> (state) { where state: state }
  # scope :price, -> (price) { where price: price }



  before_create :compute_total

  def check_dates
    if self.start_date > self.end_date
      errors.add(:Date, "Check-in cannot be later than check-out")
    end
  end

  def compute_total
    daily_rate = Listing.find(self.listing_id).price
    self.total_price = (self.end_date - self.start_date)*daily_rate.to_i
  end

  def reserved_date
    existing_reserve = Reservation.where(listing_id: self.listing_id) #array of reservations

    # unavailable_date = current_listing
    start_date = self.start_date
    end_date = self.end_date
    # reserved = (start_date...end_date).to_a

    # iterate over array of date

    existing_reserve.each do |x|
      # byebug
      all_reserved = x.start_date..x.end_date
      if ((start_date.to_date..end_date.to_date).overlaps?all_reserved) && x != self
        errors.add(:Property, "not available at the selected date. Please try other date")
        break
      end
    end
  end
end
