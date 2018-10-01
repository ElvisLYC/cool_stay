class HomeController < ApplicationController
  def index
    @listings = Listing.where(verify: true)
  end
end
