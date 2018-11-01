class HomeController < ApplicationController
  def index
    @listings = Listing.where(verify: true)
    @listings_page = @listings.page params[:page]
  end
end
