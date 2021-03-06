class ListingsController < ApplicationController
  def index
    @listings = Listing.where(verify: true)
    @listings_page = @listings.page params[:page]

  end

# to refactor search -> filter
# test scoping/filtering --> to refactor to module
  def search
    @listings = Listing.where(verify: true)
    x = params[:listing][:property_title]
    y = params[:listing][:location]
    @listings = @listings.filter(property_title:x,location:y)
    @listings_page = @listings.page params[:page]
  end

  def global_search
    @listings = Listing.where(verify: true)
      if params[:listing][:term]
        @listings = @listings.search_by_listings(params[:listing][:term])
      else
        @Listings = @listings
      end
    @listings_page = @listings.page params[:page]
  end

  def ajax_search
    @listings = Listing.where(verify: true)
    @listings = Listing.search_by_listings(params["query"]).pluck(:location).uniq
    respond_to do |format|
      format.json { render json: @listings }
      format.js # remote: true is sent a js format and sends you to search.js.erb
    end
  end

  def show
    @listing = Listing.find(params[:id])
    @listings = Listing.where(verify: true)
    @reservation = Reservation.new
    @listings_page = @listings.page params[:page]
    @user = User.find(@listing.user_id)
    @host = @user
  end

  def new
    @user = current_user
    @listing = Listing.new
    # @listings = Article.all
    @user_id = User.find(current_user.id)
  end

  def edit
    @listing = Listing.find(params[:id])
    @user_id = User.find(current_user.id)
  end

  def verify
    @user_ranking = current_user.role
    @listings = Listing.where(verify:true)
    @listings_page = Listing.order(:location).page params[:page]
    @user_id = User.find(current_user.id)
  end

  def verify!
    @listing = Listing.find(params[:id])
    @listing.update(verify: true)
    redirect_to listing_pending_verification_path
  end

  def create

    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    @user = User.find(@listing.user_id)

    if @listing.save
      redirect_to listing_confirmation_path
    else
      render 'new'
    end
    end

  def update
  @listing = Listing.find(params[:id])
    if @listing.update(listing_params)
      redirect_to @listing
    else
      render 'edit'
    end
end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to root_path
  end

  def delete_photo
    @listing = Listing.find(params[:id])
    @listing.remove_photos!
    @listing.save
    redirect_to root_path
  end

  private
    def listing_params
      params.require(:listing).permit(:property_title, :location, :price, :description, :user_id, {photos:[]}, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address)
    end
end
