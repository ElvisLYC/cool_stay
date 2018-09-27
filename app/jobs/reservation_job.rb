class ReservationJob < ApplicationJob
  queue_as :default

  def perform(reservation, user)
    ReservationMailer.booking_email(reservation, user).deliver_later # why deliver_later?
  end
end
