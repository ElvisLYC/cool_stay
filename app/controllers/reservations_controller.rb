class ReservationsController < ApplicationController
  def index
    @user_id = User.find(current_user.id)
  end

  def show
    @reservation = Reservation.find(params[:id])
    @listing = Listing.find(params[:listing_id])
  end

  def new
    @user = current_user
    @reservation = Reservation.new
    @user_id = User.find(current_user.id)
  end

  def create
    details = reservation_params
    details[:start_date] = Date.strptime(reservation_params[:start_date], '%m/%d/%Y') if reservation_params[:start_date] != ""
    details[:end_date] = Date.strptime(reservation_params[:end_date], '%m/%d/%Y') if reservation_params[:end_date] != ""
    @reservation = Reservation.new(details)
    if current_user != nil
      @reservation.user_id = current_user.id
    end
    @reservation.listing_id = params[:listing_id]
    # @user = User.find(@reservation.user_id)
    @listing = Listing.find(params[:listing_id])
    @host = User.find(@listing.user_id)

    if @reservation.save
      redirect_to listing_reservation_path(@reservation.listing_id,@reservation.id) #reservations/:id
      @message = ""
    end
  end

  private
    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :remark, :user_id, :listing_id, :total_price, :payment_status)
    end

end
