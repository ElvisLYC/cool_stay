class ListingsController < ApplicationController
  def index
    # @listings = Listing.all #call those with verified and order it
    @listings = Listing.where(verify: true).order(:location)
    @listings_page = @listings.page params[:page]
    # @listings = Listing.order('created_at DESC').page(params[:page]).per(25)
  end

  def show
    @listing = Listing.find(params[:id])
    @user = User.find(@listing.user_id)
  end

  def new
    @user = current_user
    @listing = Listing.new
    @listings = Article.all
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def verify
    @listings = Listing.where(verify:true)
    @listings_page = Listing.order(:location).page params[:page]
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
      redirect_to @listing
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
    redirect_to listings_path
  end
  private
    def listing_params
      params.require(:listing).permit(:property_title, :location, :price, :description, :user_id)
    end
end
