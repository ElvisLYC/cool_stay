class BraintreeController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
  end

  def checkout
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    result = Braintree::Transaction.sale(
     :amount => "10.00", #this is currently hardcoded
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )

    if result.success?
      # add email execution here
      @reservation = Reservation.find(params[:id])
      @reservation.update(payment_status: true)
      @user = User.find(@reservation.user_id)
      # email to host upon payment.
      ReservationJob.perform_later(@reservation, @user)
      # email to user upon payment
      PaymentJob.perform_later(@reservation, @user)
      # Tell the UserMailer to send a welcome email after save

      # ReservationMailer.perform_later(@reservation, @user)

      redirect_to :root, :flash => { :success => "Transaction successful!" }
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end
  end
end
