class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :reserved_date
  before_create :compute_total




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
      if (start_date.to_date..end_date.to_date).overlaps?all_reserved
        errors.add(:Property, "not available at the selected date. Please try other date")
        break
      end
    end
  end
end
