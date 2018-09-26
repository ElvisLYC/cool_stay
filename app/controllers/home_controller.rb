class HomeController < ApplicationController
  def index
    @user_id = User.find(current_user.id)
  end
end
