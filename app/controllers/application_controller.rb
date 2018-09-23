class ApplicationController < ActionController::Base
  include Clearance::Controller
  def index
    @user_id = User.find(current_user.id)
  end

  def application
    @user_id = User.find(current_user.id)
  end

  def profile
    @user_profile = User.find(params[:id])
    @user_listing = Listing.where(user_id: params[:id])
  end
end
