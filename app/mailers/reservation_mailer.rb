class ReservationMailer < ApplicationMailer

  def booking_email(reservation, user)
    @reservation = reservation
    @user = user
    # @url = listing_reservation_path(which listing?,which reservation?)
    mail(to: '365webdev@gmail.com', subject: 'Booking Email')
  end

  def payment_email(reservation, user)
    @reservation = reservation
    @user = user
    mail(to: user.email, subject: 'Payment Receipt')
  end




  # receiving email
#   def receive(email)
#   page = Page.find_by(address: email.to.first)
#   page.emails.create(
#     subject: email.subject,
#     body: email.body
#   )
#
#     if email.has_attachments?
#       email.attachments.each do |attachment|
#         page.attachments.create({
#           file: attachment,
#           description: email.subject
#         })
#       end
#     end
# end

end
